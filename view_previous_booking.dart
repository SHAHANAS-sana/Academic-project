
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/worker/wrkr_edit_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const previous_bookings(title: 'Flutter Demo Home Page'),
    );
  }
}

class previous_bookings extends StatefulWidget {
  const previous_bookings({super.key, required this.title});

  final String title;

  @override
  State<previous_bookings> createState() => _previous_bookingsState();
}

class _previous_bookingsState extends State<previous_bookings> {

  _previous_bookingsState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> slot_ = <String>[];
  List<String> date_ = <String>[];
  List<String> name_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> slot = <String>[];
    List<String> date = <String>[];
    List<String> name = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String sid = sh.getString('sid').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/User_previous_bookings/';


      var data = await http.post(Uri.parse(url), body: {
        "lid":lid,
        "sid":sid,


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        slot.add(arr[i]['slot'].toString());
        date.add(arr[i]['date'].toString());
        name.add(arr[i]['Evstationname'].toString());

      }

      setState(() {
        id_ = id;
        slot_ = slot;
        date_ = date;
        name_ = name;

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.primary,

          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press: " + index.toString());
              },
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.deepPurple[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // You can add an icon or image here if needed, for example:
                        // CircleAvatar(radius: 30, backgroundImage: NetworkImage(photo_[index])),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Date Text
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "Date: ${date_[index]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.deepPurple[700],
                                  ),
                                ),
                              ),
                              // Slot Text
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "Slot: ${slot_[index]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              // Name Text
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "Name: ${name_[index]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

          },
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
