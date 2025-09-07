import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black.withOpacity(0.7)),
        ),
      ),
      home: const ViewReminder(title: 'View Reminders'),
    );
  }
}

class ViewReminder extends StatefulWidget {
  const ViewReminder({super.key, required this.title});

  final String title;

  @override
  State<ViewReminder> createState() => _ViewReminderState();
}

class _ViewReminderState extends State<ViewReminder> {
  _ViewReminderState() {
    viewNotifications();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> reminder_ = <String>[];
  // bool _isLoading = false; // Track loading state

  Future<void> viewNotifications() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> reminder = <String>[];

    // setState(() {
    //   _isLoading = true;
    // });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_reminder/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        reminder.add(arr[i]['reminder'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        reminder_ = reminder;
        // _isLoading = false;
      });
    } catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
      print("Error: ${e.toString()}");
      _showSnackBar('Error fetching reminders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        elevation: 8, // Add a subtle shadow
      ),
      body // Add shimmer loading effect
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                // Optional: Add tap functionality if needed
              },
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                shadowColor: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date_[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            SizedBox(height: 8),
                            Text(
                              reminder_[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.delete, color: Colors.red, size: 32),
                      //   onPressed: () async {
                      //     await _deleteReminder(id_[index]);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteReminder(String id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      var response = await http.post(Uri.parse('$url/delete_reminder/'), body: {
        'lid': lid,
        'id': id,
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'ok') {
          _showSnackBar('Reminder deleted successfully');
          setState(() {
            id_.remove(id);
            date_.removeAt(id_.indexOf(id));
            reminder_.removeAt(id_.indexOf(id));
          });
        } else {
          _showSnackBar('Failed to delete reminder');
        }
      } else {
        _showSnackBar('Network error, please try again');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    }
  }

  // Helper function to show SnackBars
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Shimmer loading effect
  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5, // Add a few loading placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 200,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
