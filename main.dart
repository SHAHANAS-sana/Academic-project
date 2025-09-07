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
      home: const view_reminder(title: 'Flutter Demo Home Page'),
    );
  }
}

class view_reminder extends StatefulWidget {
  const view_reminder({super.key, required this.title});

  final String title;

  @override
  State<view_reminder> createState() => _view_reminderState();
}

class _view_reminderState extends State<view_reminder> {

  _view_reminderState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> reminder_ = <String>[];




  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> reminder = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_reminder/';

      var data = await http.post(Uri.parse(url), body: {
        "lid":lid


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        reminder.add(arr[i]['reminder']);

      }

      setState(() {
        id_ = id;
        date_ = date;
        reminder_ = reminder;


      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child:
                        Row(
                            children: [
                              // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(date_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(reminder_[index]),)


                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //
                                  //     final sh =await SharedPreferences.getInstance();
                                  //     sh.setString("sid", id_[index]);
                                  //
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(builder: (context) => edit_service(title: "Edit service")),
                                  //     );
                                  //   },
                                  //   child: Text("edit"),
                                  // ),
                                  //
                                  // ElevatedButton(onPressed: () async{
                                  //
                                  //   SharedPreferences sh = await SharedPreferences.getInstance();
                                  //   String url = sh.getString('url').toString();
                                  //   String sid=id_[index];
                                  //
                                  //   final urls = Uri.parse('$url/User_view_reminder_usr/');
                                  //   try {
                                  //     final response = await http.post(urls, body: {
                                  //       'sid':sid,
                                  //     });
                                  //     if (response.statusCode == 200) {
                                  //       String status = jsonDecode(response.body)['status'];
                                  //       if (status=='ok') {
                                  //
                                  //         // String lid=jsonDecode(response.body)['lid'];
                                  //         //   sh.setString("lid", lid);
                                  //         Fluttertoast.showToast(msg: "deleted successfully");
                                  //
                                  //         Navigator.push(context, MaterialPageRoute(
                                  //           builder: (context) => view_reminder(title: "Home"),));
                                  //       }else {
                                  //         Fluttertoast.showToast(msg: 'Not Found');
                                  //       }
                                  //     }
                                  //     else {
                                  //       Fluttertoast.showToast(msg: 'Network Error');
                                  //     }
                                  //   }
                                  //   catch (e){
                                  //     Fluttertoast.showToast(msg: e.toString());
                                  //   }
                                  // }, child: Text("delete"))
                                ],
                              ),
                            ]
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}