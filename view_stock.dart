import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/payment.dart';
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
      title: 'View Stock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const view_stock_usr(title: 'View Stock'),
    );
  }
}

class view_stock_usr extends StatefulWidget {
  const view_stock_usr({super.key, required this.title});

  final String title;

  @override
  State<view_stock_usr> createState() => _view_stock_usrState();
}

class _view_stock_usrState extends State<view_stock_usr> {
  _view_stock_usrState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> stock_ = <String>[];
  List<String> fuel_ = <String>[];
  List<String> name_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> stock = <String>[];
    List<String> fuel = <String>[];
    List<String> name = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String sid = sh.getString('sid').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/view_stock_usr/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
        "sid": sid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        stock.add(arr[i]['stock'].toString());
        fuel.add(arr[i]['fuel'].toString());
        name.add(arr[i]['name'].toString());
      }

      setState(() {
        id_ = id;
        stock_ = stock;
        fuel_ = fuel;
        name_ = name;
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
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 5,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.all(8),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Icon(Icons.local_gas_station, size: 50, color: Colors.deepPurple),
                title: Text(
                  name_[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepPurple[900],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Stock: ${stock_[index]}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      "Fuel: ${fuel_[index]}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();

                        final urls = Uri.parse('$url/fuel_send_req/');
                        try {
                          final response = await http.post(urls, body: {
                            'lid': lid,
                            'sid': id_[index],
                          });
                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Fluttertoast.showToast(msg: "Request sent successfully");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
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
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: Colors.deepPurpleAccent,
                      ),
                      child: Text(
                        "Request Fuel",
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
