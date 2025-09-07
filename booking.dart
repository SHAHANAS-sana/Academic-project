
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
      home: const booking_usr(title: 'Flutter Demo Home Page'),
    );
  }
}

class booking_usr extends StatefulWidget {
  const booking_usr({super.key, required this.title});

  final String title;

  @override
  State<booking_usr> createState() => _booking_usrState();
}

class _booking_usrState extends State<booking_usr> {

  _booking_usrState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];




  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> date = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String sid = sh.getString('sid').toString();
      String url = '$urls/User_booking_usr/';

      var data = await http.post(Uri.parse(url), body: {
        "lid":lid,
        "sid":sid


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);

      }

      setState(() {
        id_ = id;
        date_ = date;


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


                                  ElevatedButton(
                                    onPressed: () async {

                                      final sh =await SharedPreferences.getInstance();
                                      sh.setString("sid", id_[index]);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => edit_service(title: "Edit service")),
                                      );
                                    },
                                    child: Text("edit"),
                                  ),

                                  ElevatedButton(onPressed: () async{

                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    String url = sh.getString('url').toString();
                                    String sid=id_[index];

                                    final urls = Uri.parse('$url/User_booking_usr/');
                                    try {
                                      final response = await http.post(urls, body: {
                                        'sid':sid,
                                      });
                                      if (response.statusCode == 200) {
                                        String status = jsonDecode(response.body)['status'];
                                        if (status=='ok') {

                                          // String lid=jsonDecode(response.body)['lid'];
                                          //   sh.setString("lid", lid);
                                          Fluttertoast.showToast(msg: "slot booked");

                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => booking_usr(title: "Home"),));
                                        }else {
                                          Fluttertoast.showToast(msg: 'Not Found');
                                        }
                                      }
                                      else {
                                        Fluttertoast.showToast(msg: 'Network Error');
                                      }
                                    }
                                    catch (e){
                                      Fluttertoast.showToast(msg: e.toString());
                                    }
                                  }, child: Text("delete"))
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
