import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/view_slot.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black54),
          headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      home: const view_EV_usr(title: 'EV Station Viewer'),
    );
  }
}

class view_EV_usr extends StatefulWidget {
  const view_EV_usr({super.key, required this.title});

  final String title;

  @override
  State<view_EV_usr> createState() => _view_EV_usrState();
}

class _view_EV_usrState extends State<view_EV_usr> {

  _view_EV_usrState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> place_ = <String>[];
  List<String> latitude_ = <String>[];
  List<String> longtitude_ = <String>[];
  List<String> state_ = <String>[];
  List<String> city_ = <String>[];
  List<String> pin_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> photo = <String>[];
    List<String> place = <String>[];
    List<String> latitude = <String>[];
    List<String> longtitude = <String>[];
    List<String> state = <String>[];
    List<String> city = <String>[];
    List<String> pin = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_evstation/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        photo.add(sh.getString("img_url").toString() + arr[i]['photo'].toString());
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
        place_ = place;
        latitude_ = latitude;
        longtitude_ = longtitude;
        state_ = state;
        city_ = city;
        pin_ = pin;
      });

    } catch (e) {
      Fluttertoast.showToast(msg: "Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
      return false;
    },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              
            },
            
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
          elevation: 4,
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      photo_[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    name_[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        place_[index],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin, size: 14, color: Colors.blue),
                          SizedBox(width: 5),
                          Text('${latitude_[index]}', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin, size: 14, color: Colors.blue),
                          SizedBox(width: 5),
                          Text('${longtitude_[index]}', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'City: ${city_[index]}, State: ${state_[index]}, PIN: ${pin_[index]}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    onPressed: () async {
                      final sh = await SharedPreferences.getInstance();
                      sh.setString("sid", id_[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => view_slot_user(title: "View Slot")),
                      );
                    },
                    icon: Icon(Icons.view_column),
                    label: Text("View Slot"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
