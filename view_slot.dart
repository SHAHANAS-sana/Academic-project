import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/user_home.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:roadmate/user/booking.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:roadmate/worker/wrkr_edit_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV Station Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black54),
          headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      home: const view_slot_user(title: 'View EV Slot'),
    );
  }
}

class view_slot_user extends StatefulWidget {
  const view_slot_user({super.key, required this.title});

  final String title;

  @override
  State<view_slot_user> createState() => _view_slot_userState();
}

class _view_slot_userState extends State<view_slot_user> {
  _view_slot_userState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> slotno_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> slotno = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String sid = sh.getString('sid').toString();

      String url = '$urls/User_view_slot_user/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
        "sid": sid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        slotno.add(arr[i]['slotno'].toString());
      }

      setState(() {
        id_ = id;
        slotno_ = slotno;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        elevation: 5,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(8),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.location_on, color: Colors.white),
                ),
                title: Text(
                  'Slot: ${slotno_[index]}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Available for booking',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();
                        String sid = id_[index];

                        final urls = Uri.parse('$url/User_booking_usr/');
                        try {
                          final response = await http.post(urls, body: {
                            'sid': sid,
                            'lid': lid,
                          });

                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Fluttertoast.showToast(msg: "Booking successfully");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            } else {
                              Fluttertoast.showToast(msg: 'Slot not available');
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Network Error');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Book Slot",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
