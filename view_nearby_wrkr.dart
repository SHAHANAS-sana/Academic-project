import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/view_service.dart';
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
      title: 'Nearby Workers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const nearby_wrkr(title: 'Nearby Workers'),
    );
  }
}

class nearby_wrkr extends StatefulWidget {
  const nearby_wrkr({super.key, required this.title});

  final String title;

  @override
  State<nearby_wrkr> createState() => _nearby_wrkrState();
}

class _nearby_wrkrState extends State<nearby_wrkr> {

  _nearby_wrkrState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> email_  = <String>[];
  List<String> phone_  = <String>[];
  List<String> place_  = <String>[];
  List<String> latitude_  = <String>[];
  List<String> longtitude_  = <String>[];
  List<String> state_  = <String>[];
  List<String> city_  = <String>[];
  List<String> pin_  = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> photo = <String>[];
    List<String> email  = <String>[];
    List<String> phone  = <String>[];
    List<String> place  = <String>[];
    List<String> latitude  = <String>[];
    List<String> longtitude  = <String>[];
    List<String> state  = <String>[];
    List<String> city  = <String>[];
    List<String> pin  = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/User_user_view_worker/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        photo.add(sh.getString("img_url").toString() + arr[i]['photo'].toString());
        email.add(arr[i]['email'].toString());
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place'].toString());
        latitude.add(arr[i]['latitude'].toString());
        longtitude.add(arr[i]['longtitude'].toString());
        city.add(arr[i]['city'].toString());
        pin.add(arr[i]['pin'].toString());
        state.add(arr[i]['state'].toString());
      }

      setState(() {
        id_ = id;
        name_ = name;
        photo_ = photo;
        email_ = email;
        phone_ = phone;
        place_ = place;
        latitude_ = latitude;
        longtitude_ = longtitude;
        state_ = state;
        city_ = city;
        pin_ = pin;
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
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(photo_[index]),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text(
                  name_[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Email: ${email_[index]}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      "Phone: ${phone_[index]}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final sh = await SharedPreferences.getInstance();
                        sh.setString("wid", id_[index]);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => view_service(title: "View Service")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[700],
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Services",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        String url = "https://maps.google.com?q=" + latitude_[index] + "," + longtitude_[index];
                        if (await canLaunch(url)) {
                          await launch(url, forceWebView: true, enableJavaScript: true);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[700],
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Locator",
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
