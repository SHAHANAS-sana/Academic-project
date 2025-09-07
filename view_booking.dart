import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/user_home.dart';
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
      title: 'View Bookings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const view_booking(title: 'View Bookings'),
    );
  }
}

class view_booking extends StatefulWidget {
  const view_booking({super.key, required this.title});

  final String title;

  @override
  State<view_booking> createState() => _view_bookingState();
}

class _view_bookingState extends State<view_booking> {

  _view_bookingState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> slot_ = <String>[];
  List<String> Evstationname_ = <String>[];
  List<String> evid_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> slot = <String>[];
    List<String> Evstationname = <String>[];
    List<String> evid = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      String url = '$urls/User_view_book/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        slot.add(arr[i]['slot'].toString());
        Evstationname.add(arr[i]['Evstationname'].toString());
        evid.add(arr[i]['evid'].toString());
      }

      setState(() {
        id_ = id;
        slot_ = slot;
        Evstationname_ = Evstationname;
        evid_ = evid;
      });

    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              elevation: 8,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.all(8),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Evstationname_[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Slot: ${slot_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();
                        String eid = evid_[index];

                        final urls = Uri.parse('$url/user_send_evreq/');

                        try {
                          final response = await http.post(urls, body: {
                            'lid': lid,
                            'eid': eid,
                            'bid': id_[index],
                          });

                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Fluttertoast.showToast(msg: "Request sent successfully");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            } else {
                              Fluttertoast.showToast(msg: 'Not Found');
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Network Error');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[700],
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Send Request",
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
