import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/payment.dart';
import 'package:roadmate/user/user_home.dart';
import 'package:roadmate/user/workerpayment.dart';
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
      home: const user_view_req_service_status(title: 'Requested Service Status'),
    );
  }
}

class user_view_req_service_status extends StatefulWidget {
  const user_view_req_service_status({super.key, required this.title});

  final String title;

  @override
  State<user_view_req_service_status> createState() => _user_view_req_service_statusState();
}

class _user_view_req_service_statusState extends State<user_view_req_service_status> {

  _user_view_req_service_statusState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> servicename_ = <String>[];
  List<String> serviceamount_ = <String>[];
  List<String> description_ = <String>[];
  List<String> rstatus_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> servicename = <String>[];
    List<String> serviceamount = <String>[];
    List<String> description = <String>[];
    List<String> rstatus = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_Req_service/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        servicename.add(arr[i]['servicename'].toString());
        serviceamount.add(arr[i]['serviceamount'].toString());
        description.add(arr[i]['description'].toString());
        rstatus.add(arr[i]['rstatus'].toString());
      }

      setState(() {
        id_ = id;
        servicename_ = servicename;
        serviceamount_ = serviceamount;
        description_ = description;
        rstatus_ = rstatus;
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
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.deepPurple[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Name
                    Text(
                      servicename_[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Service Amount
                    Text(
                      "Amount: \$${serviceamount_[index]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description
                    Text(
                      "Description: ${description_[index]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Request Status
                    Text(
                      "Status: ${rstatus_[index]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: rstatus_[index] == 'approved'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Payment Button (visible only for approved status)
                    if (rstatus_[index] == 'approved') ...[
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences sh = await SharedPreferences.getInstance();
                          sh.setString("amount", serviceamount_[index]);
                          sh.setString("id", id_[index]);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => user_worker_payment_page()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Proceed to Payment",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ]
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
