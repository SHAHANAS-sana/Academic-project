import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/payment.dart';
import 'package:roadmate/user/user_home.dart';
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
      home: const user_view_req_service_status_ev(title: 'Service Request Status'),
    );
  }
}

class user_view_req_service_status_ev extends StatefulWidget {
  const user_view_req_service_status_ev({super.key, required this.title});

  final String title;

  @override
  State<user_view_req_service_status_ev> createState() =>
      _user_view_req_service_status_evState();
}

class _user_view_req_service_status_evState
    extends State<user_view_req_service_status_ev> {
  _user_view_req_service_status_evState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> evid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> slotno_ = <String>[];
  List<String> evstationame_ = <String>[];
  List<String> amount_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> evid = <String>[];
    List<String> date = <String>[];
    List<String> slotno = <String>[];
    List<String> evstationame = <String>[];
    List<String> amount = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/User_view_Req_slot/';

      var data = await http.post(Uri.parse(url), body: {"lid": lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        evid.add(arr[i]['evid'].toString());
        date.add(arr[i]['date'].toString());
        slotno.add(arr[i]['slotno'].toString());
        evstationame.add(arr[i]['evstationame'].toString());
        amount.add(arr[i]['amount'].toString());
      }

      setState(() {
        id_ = id;
        evid_ = evid;
        date_ = date;
        slotno_ = slotno;
        evstationame_ = evstationame;
        amount_ = amount;
      });

      print(statuss);
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
        elevation: 5.0,
      ),
      body:


      ListView.builder(
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
                    Text(
                      'Date: ${date_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Slot No: ${slotno_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'EV Station Name: ${evstationame_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Amount: ₹${amount_[index]}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh =
                        await SharedPreferences.getInstance();
                        sh.setString("amount", amount_[index]);
                        sh.setString("id", id_[index]);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => user_payment_page()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
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
