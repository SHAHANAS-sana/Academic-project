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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const view_service(title: 'View Services'),
    );
  }
}

class view_service extends StatefulWidget {
  const view_service({super.key, required this.title});

  final String title;

  @override
  State<view_service> createState() => _view_serviceState();
}

class _view_serviceState extends State<view_service> {
  _view_serviceState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> servicename_ = <String>[];
  List<String> serviceamount_ = <String>[];
  List<String> description_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> servicename = <String>[];
    List<String> serviceamount = <String>[];
    List<String> description = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String wid = sh.getString('wid').toString();
      String url = '$urls/user_view_service/';

      var data = await http.post(Uri.parse(url), body: {
        "wid": wid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        servicename.add(arr[i]['servicename']);
        serviceamount.add(arr[i]['serviceamount']);
        description.add(arr[i]['description']);
      }

      setState(() {
        id_ = id;
        servicename_ = servicename;
        serviceamount_ = serviceamount;
        description_ = description;
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
              elevation: 10,
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
                      servicename_[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Amount: ${serviceamount_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description_[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();
                        String sid = id_[index];

                        final urls = Uri.parse('$url/user_send_wrokreq/');

                        try {
                          final response = await http.post(urls, body: {
                            'sid': sid,
                            'lid': lid,
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
