// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:roadmate/user/user_home.dart';
// import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
// import 'package:roadmate/worker/wrkr_home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
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
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const sendcomplaint(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class sendcomplaint extends StatefulWidget {
//   const sendcomplaint({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<sendcomplaint> createState() => _sendcomplaintState();
// }
//
// class _sendcomplaintState extends State<sendcomplaint> {
//   TextEditingController complaint = TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             Padding(padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: complaint,
//                 decoration: InputDecoration(
//                     labelText: "Enter your complaint"
//                 ),),
//             ),
//
//
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text("complaint"))
//
//           ],
//         ),),
//
//     );
//   }
//
//
//   void _send_data() async{
//
//
//     String sn=complaint.text;
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/User_view_complaint_usr/');
//     try {
//       final response = await http.post(urls, body: {
//         'complaint':sn,
//         'lid':lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           // String lid=jsonDecode(response.body)['lid'];
//           //   sh.setString("lid", lid);
//             Fluttertoast.showToast(msg: " send complaint   successfully");
//
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomeScreen(),));
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
//
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black.withOpacity(0.7)),
        ),
      ),
      home: const SendComplaintScreen(title: 'Submit a Complaint'),
    );
  }
}

class SendComplaintScreen extends StatefulWidget {
  const SendComplaintScreen({super.key, required this.title});

  final String title;

  @override
  State<SendComplaintScreen> createState() => _SendComplaintScreenState();
}

class _SendComplaintScreenState extends State<SendComplaintScreen> {
  TextEditingController complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Complaint Input Field
              TextFormField(
                controller: complaintController,
                decoration: InputDecoration(
                  labelText: "Enter your complaint",
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.deepPurpleAccent,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 4,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  _sendData();
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8, // Button shadow
                ),
                child: Text(
                  "Submit Complaint",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    String complaintText = complaintController.text;
    if (complaintText.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a complaint before submitting.");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_view_complaint_usr/');

    try {
      final response = await http.post(urls, body: {
        'complaint': complaintText,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Complaint sent successfully");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Failed to send complaint');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

