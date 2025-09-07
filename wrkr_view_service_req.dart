import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/worker/wrkr_edit_service.dart';
import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Requests',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const wrkr_view_service_req(title: 'Service Requests'),
    );
  }
}

class wrkr_view_service_req extends StatefulWidget {
  const wrkr_view_service_req({super.key, required this.title});

  final String title;

  @override
  State<wrkr_view_service_req> createState() => _wrkr_view_service_reqState();
}

class _wrkr_view_service_reqState extends State<wrkr_view_service_req> {

  _wrkr_view_service_reqState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> status_ = <String>[];
  List<String> name_ = <String>[];
  List<String> email_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];
  List<String> state_ = <String>[];
  List<String> city_ = <String>[];
  List<String> pin_ = <String>[];
  List<String> servicename_ = <String>[];
  List<String> serviceamount_ = <String>[];
  List<String> description_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> status = <String>[];
    List<String> name = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> state = <String>[];
    List<String> city = <String>[];
    List<String> pin = <String>[];
    List<String> servicename = <String>[];
    List<String> serviceamount = <String>[];
    List<String> description = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/worker_view_service_req/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        status.add(arr[i]['status'].toString());
        name.add(arr[i]['name'].toString());
        email.add(arr[i]['email'].toString());
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place'].toString());
        state.add(arr[i]['state'].toString());
        city.add(arr[i]['city'].toString());
        pin.add(arr[i]['pin'].toString());
        servicename.add(arr[i]['servicename']);
        serviceamount.add(arr[i]['serviceamount']);
        description.add(arr[i]['description']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        status_ = status;
        name_ = name;
        email_ = email;
        phone_ = phone;
        place_ = place;
        state_ = state;
        city_ = city;
        pin_ = pin;
        servicename_ = servicename;
        serviceamount_ = serviceamount;
        description_ = description;
      });

    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request Date: ${date_[index]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text("Service Name: ${servicename_[index]}"),
                    SizedBox(height: 8),
                    Text("Customer: ${name_[index]}"),
                    Text("Email: ${email_[index]}"),
                    Text("Phone: ${phone_[index]}"),
                    Text("Place: ${place_[index]}"),
                    Text("State: ${state_[index]}"),
                    Text("City: ${city_[index]}"),
                    Text("Pin Code: ${pin_[index]}"),
                    SizedBox(height: 12),
                    Text(
                      "Description: ${description_[index]}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String sid = id_[index];

                            final urls = Uri.parse('$url/approve_service_req/');
                            try {
                              final response = await http.post(urls, body: {
                                'sid': sid,
                              });
                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(msg: "Approved successfully");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen1()),
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
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text("Approve"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String sid = id_[index];

                            final urls = Uri.parse('$url/reject_service_req/');
                            try {
                              final response = await http.post(urls, body: {
                                'sid': sid,
                              });
                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(msg: "Rejected");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen1()),
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
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text("Reject"),
                        ),
                      ],
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
