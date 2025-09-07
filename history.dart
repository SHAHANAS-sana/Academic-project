
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
      home: const history_usr(title: 'Flutter Demo Home Page'),
    );
  }
}

class history_usr extends StatefulWidget {
  const history_usr({super.key, required this.title});

  final String title;

  @override
  State<history_usr> createState() => _history_usrState();
}

class _history_usrState extends State<history_usr> {

  _history_usrState() {
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
      String url = '$urls/User_history_usr/';


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
        body:ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                elevation: 8,
                shadowColor: Colors.deepPurple[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(8),
                child: InkWell(
                  onLongPress: () {
                    print("long press on item $index");
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${date_[index]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.deepPurple[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Slot: ${slot_[index]}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Name: ${name_[index]}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 16),
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
