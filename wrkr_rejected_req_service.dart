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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const wrkr_view_rejected_req(title: 'Rejected Service Requests'),
    );
  }
}

class wrkr_view_rejected_req extends StatefulWidget {
  const wrkr_view_rejected_req({super.key, required this.title});

  final String title;

  @override
  State<wrkr_view_rejected_req> createState() => _wrkr_view_rejected_reqState();
}

class _wrkr_view_rejected_reqState extends State<wrkr_view_rejected_req> {
  _wrkr_view_rejected_reqState() {
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
      String url = '$urls/wrkr_view_rejected_req/';

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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text(date_[index], style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(),
                    Text("Service Name: ${servicename_[index]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Customer Name: ${name_[index]}", style: TextStyle(fontSize: 14)),
                    Text("Email: ${email_[index]}", style: TextStyle(fontSize: 14)),
                    Text("Phone: ${phone_[index]}", style: TextStyle(fontSize: 14)),
                    Text("Location: ${place_[index]}, ${city_[index]}, ${state_[index]}, ${pin_[index]}", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 8),
                    Text("Service Amount: ${serviceamount_[index]}", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Description: ${description_[index]}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     Fluttertoast.showToast(msg: "Service approved");
                        //   },
                        //   child: Text("Approve"),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.green,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     Fluttertoast.showToast(msg: "Service rejected");
                        //   },
                        //   child: Text("Reject"),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.red,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
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
