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
      home: const user_view_fuel_req_status(title: 'Fuel Request Status'),
    );
  }
}

class user_view_fuel_req_status extends StatefulWidget {
  const user_view_fuel_req_status({super.key, required this.title});

  final String title;

  @override
  State<user_view_fuel_req_status> createState() => _user_view_fuel_req_statusState();
}

class _user_view_fuel_req_statusState extends State<user_view_fuel_req_status> {
  _user_view_fuel_req_statusState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> fuelname_ = <String>[];
  List<String> fuelstationame_ = <String>[];
  List<String> rstatus_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> fuelname = <String>[];
    List<String> fuelstationame = <String>[];
    List<String> rstatus = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_fuel_Req_status/';

      var data = await http.post(Uri.parse(url), body: {"lid": lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        fuelname.add(arr[i]['fuelname'].toString());
        fuelstationame.add(arr[i]['fuelstationame'].toString());
        rstatus.add(arr[i]['rstatus'].toString());
      }

      setState(() {
        id_ = id;
        fuelname_ = fuelname;
        fuelstationame_ = fuelstationame;
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
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fuel Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          fuelname_[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          rstatus_[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: rstatus_[index] == 'approved'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fuel Station',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          fuelstationame_[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (rstatus_[index] == 'approved') ...{
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          sh.setString("amount", fuelstationame_[index]);
                          sh.setString("id", id_[index]);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => user_worker_payment_page()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Proceed to Payment',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    }
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
