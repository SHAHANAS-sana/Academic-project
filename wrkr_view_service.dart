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
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//         useMaterial3: true,
//       ),
//       home: const wrkr_view_service(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class wrkr_view_service extends StatefulWidget {
//   const wrkr_view_service({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<wrkr_view_service> createState() => _wrkr_view_serviceState();
// }
//
// class _wrkr_view_serviceState extends State<wrkr_view_service> {
//
//   _wrkr_view_serviceState() {
//     view_notification();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> servicename_ = <String>[];
//   List<String> serviceamount_ = <String>[];
//   List<String> description_ = <String>[];
//
//
//
//   Future<void> view_notification() async {
//     List<String> id = <String>[];
//     List<String> servicename = <String>[];
//     List<String> serviceamount = <String>[];
//     List<String> description = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/view_service/';
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
//         servicename.add(arr[i]['servicename']);
//         serviceamount.add(arr[i]['serviceamount']);
//         description.add(arr[i]['description']);
//
//       }
//
//       setState(() {
//         id_ = id;
//         servicename_ = servicename;
//         serviceamount_ = serviceamount;
//         description_ = description;
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
//                         elevation: 8,
//                         margin: EdgeInsets.all(10),
//                         child:
//                         Row(
//                             children: [
//                               // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(servicename_[index]),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(serviceamount_[index]),
//                                   ), Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Text(description_[index]),
//                                   ),
//
//                                   ElevatedButton(
//                                     onPressed: () async {
//
//                                       final sh =await SharedPreferences.getInstance();
//                                       sh.setString("sid", id_[index]);
//
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (context) => edit_service(title: "Edit service")),
//                                       );
//                                     },
//                                     child: Text("edit"),
//                                   ),
//
//                                   // ElevatedButton(onPressed: () async{
//                                   //
//                                   //   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   //   String url = sh.getString('url').toString();
//                                   //   String lid = sh.getString('lid').toString();
//                                   //   String sid=id_[index];
//                                   //
//                                   //
//                                   //   final urls = Uri.parse('$url/wrkr_send_req/');
//                                   //   try {
//                                   //     final response = await http.post(urls, body: {
//                                   //
//                                   //       'lid':lid,
//                                   //       // 'sid':sid
//                                   //
//                                   //     });
//                                   //     if (response.statusCode == 200) {
//                                   //       String status = jsonDecode(response.body)['status'];
//                                   //       if (status=='ok') {
//                                   //
//                                   //         // String lid=jsonDecode(response.body)['lid'];
//                                   //         //   sh.setString("lid", lid);
//                                   //         Fluttertoast.showToast(msg: "request sented");
//                                   //
//                                   //         Navigator.push(context, MaterialPageRoute(
//                                   //           builder: (context) => wrkr_view_service(title: "Home"),));
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
//                                   // }, child: Text("send request")),
//                                   ElevatedButton(onPressed: () async{
//
//                                     SharedPreferences sh = await SharedPreferences.getInstance();
//                                     String url = sh.getString('url').toString();
//                                     String sid=id_[index];
//
//                                     final urls = Uri.parse('$url/delete_service/');
//                                     try {
//                                       final response = await http.post(urls, body: {
//                                         'sid':sid,
//                                       });
//                                       if (response.statusCode == 200) {
//                                         String status = jsonDecode(response.body)['status'];
//                                         if (status=='ok') {
//
//                                           // String lid=jsonDecode(response.body)['lid'];
//                                           //   sh.setString("lid", lid);
//                                           Fluttertoast.showToast(msg: "deleted successfully");
//
//                                           Navigator.push(context, MaterialPageRoute(
//                                             builder: (context) => wrkr_view_service(title: "Home"),));
//                                         }else {
//                                           Fluttertoast.showToast(msg: 'Not Found');
//                                         }
//                                       }
//                                       else {
//                                         Fluttertoast.showToast(msg: 'Network Error');
//                                       }
//                                     }
//                                     catch (e){
//                                       Fluttertoast.showToast(msg: e.toString());
//                                     }
//                                   }, child: Text("delete"))
//                                 ],
//                               ),
//                             ]
//                         ),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const WrkrViewService(title: 'Worker View Service'),
    );
  }
}

class WrkrViewService extends StatefulWidget {
  const WrkrViewService({super.key, required this.title});

  final String title;

  @override
  State<WrkrViewService> createState() => _WrkrViewServiceState();
}

class _WrkrViewServiceState extends State<WrkrViewService> {
  _WrkrViewServiceState() {
    viewNotification();
  }

  List<String> id_ = <String>[];
  List<String> servicename_ = <String>[];
  List<String> serviceamount_ = <String>[];
  List<String> description_ = <String>[];

  Future<void> viewNotification() async {
    List<String> id = <String>[];
    List<String> servicename = <String>[];
    List<String> serviceamount = <String>[];
    List<String> description = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/view_service/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        servicename.add(arr[i]['servicename']);
        serviceamount.add(arr[i]['serviceamount']);
        description.add(arr[i]['description']);
      }

      setState(() {
        id_ = id;
        servicename_ = servicename;
        serviceamount_ = serviceamount;
        description_ = description;
      });

      print(statuss);
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
        physics: const BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    // Service Details Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            servicename_[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Amount: ${serviceamount_[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            description_[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        // Edit Button
                        ElevatedButton(
                          onPressed: () async {
                            final sh = await SharedPreferences.getInstance();
                            sh.setString("sid", id_[index]);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => edit_service(
                                  title: "Edit Service",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            primary: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Delete Button
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh =
                            await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String sid = id_[index];

                            final urls = Uri.parse('$url/delete_service/');
                            try {
                              final response = await http.post(urls, body: {
                                'sid': sid,
                              });
                              if (response.statusCode == 200) {
                                String status =
                                jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(
                                      msg: "Deleted successfully");

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WrkrViewService(
                                          title: "Home"),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
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
