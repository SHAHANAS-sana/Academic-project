//
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:roadmate/worker/wrkr_edit_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const view_complaint(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class view_complaint extends StatefulWidget {
//   const view_complaint({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<view_complaint> createState() => _view_complaintState();
// }
//
// class _view_complaintState extends State<view_complaint> {
//
//   _view_complaintState() {
//     view_notification();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> complaint_ = <String>[];
//   List<String> reply_ = <String>[];
//   List<String> status_ = <String>[];
//
//
//
//   Future<void> view_notification() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> complaint = <String>[];
//     List<String> reply = <String>[];
//     List<String> status = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/User_user_view_complaint/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         "lid":lid
//
//
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date']);
//         complaint.add(arr[i]['complaint']);
//         reply.add(arr[i]['reply']);
//         status.add(arr[i]['status']);
//
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         complaint_ = complaint;
//         reply_ = reply;
//         status_ = status;
//
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//         appBar: AppBar(
//           leading: BackButton( ),
//           // TRY THIS: Try changing the color here to a specific color (to
//           // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//           // change color while the other colors stay the same.
//           backgroundColor: Theme.of(context).colorScheme.primary,
//
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         child:
//                         Row(
//                             children: [
//                               // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(date_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(complaint_[index]),
//                                   ), Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(reply_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(status_[index]),
//                                   ),
//
//                                   // ElevatedButton(
//                                   //   onPressed: () async {
//                                   //
//                                   //     final sh =await SharedPreferences.getInstance();
//                                   //     sh.setString("sid", id_[index]);
//                                   //
//                                   //     Navigator.push(
//                                   //       context,
//                                   //       MaterialPageRoute(builder: (context) => edit_service(title: "Edit service")),
//                                   //     );
//                                   //   },
//                                   //   child: Text("edit"),
//                                   // ),
//                                   //
//                                   // ElevatedButton(onPressed: () async{
//                                   //
//                                   //   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   //   String url = sh.getString('url').toString();
//                                   //   String sid=id_[index];
//                                   //
//                                   //   final urls = Uri.parse('$url/User_view_complaint_usr/');
//                                   //   try {
//                                   //     final response = await http.post(urls, body: {
//                                   //       'sid':sid,
//                                   //     });
//                                   //     if (response.statusCode == 200) {
//                                   //       String status = jsonDecode(response.body)['status'];
//                                   //       if (status=='ok') {
//                                   //
//                                   //         // String lid=jsonDecode(response.body)['lid'];
//                                   //         //   sh.setString("lid", lid);
//                                   //         Fluttertoast.showToast(msg: "deleted successfully");
//                                   //
//                                   //         Navigator.push(context, MaterialPageRoute(
//                                   //           builder: (context) => view_complaint(title: "Home"),));
//                                   //       }else {
//                                   //         Fluttertoast.showToast(msg: 'Not Found');
//                                   //       }
//                                   //     }
//                                   //     else {
//                                   //       Fluttertoast.showToast(msg: 'Network Error');
//                                   //     }
//                                   //   }
//                                   //   catch (e){
//                                   //     Fluttertoast.showToast(msg: e.toString());
//                                   //   }
//                                   // }, child: Text("delete"))
//                                 ],
//                               ),
//                             ]
//                         ),
//                         elevation: 8,
//                         margin: EdgeInsets.all(10),
//                       ),
//                     ],
//                   )),
//             );
//           },
//         )
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
      home: const ViewComplaintScreen(title: 'View Complaints'),
    );
  }
}

class ViewComplaintScreen extends StatefulWidget {
  const ViewComplaintScreen({super.key, required this.title});

  final String title;

  @override
  State<ViewComplaintScreen> createState() => _ViewComplaintScreenState();
}

class _ViewComplaintScreenState extends State<ViewComplaintScreen> {
  _ViewComplaintScreenState() {
    viewNotifications();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> complaint_ = <String>[];
  List<String> reply_ = <String>[];
  List<String> status_ = <String>[];

  Future<void> viewNotifications() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];
    List<String> status = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/User_user_view_complaint/';

      var data = await http.post(Uri.parse(url), body: {"lid": lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        complaint.add(arr[i]['complaint']);
        reply.add(arr[i]['reply']);
        status.add(arr[i]['status']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        reply_ = reply;
        status_ = status;
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
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      date_[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Complaint
                    Text(
                      complaint_[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Reply
                    if (reply_[index].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Reply: " + reply_[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),

                    SizedBox(height: 8),

                    // Status
                    Text(
                      "Status: " + status_[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: status_[index] == 'Resolved'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                    SizedBox(height: 12),

                    // Edit Button (Optional)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Navigate to Edit Complaint page
                        //   },
                        //   child: Text("Edit"),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.deepPurple,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Delete the complaint
                        //   },
                        //   child: Text("Delete"),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.red,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
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

