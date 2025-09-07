// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
// import 'package:roadmate/user/usr_edit_pofile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const ViewProfile());
// }
//
// class ViewProfile extends StatelessWidget {
//   const ViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Profile',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const view_profile_usr(title: 'View Profile'),
//     );
//   }
// }
//
// class view_profile_usr extends StatefulWidget {
//   const view_profile_usr({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<view_profile_usr> createState() => _view_profile_usrState();
// }
//
// class _view_profile_usrState extends State<view_profile_usr> {
//
//   @override
//   void initState() {
//     super.initState();
//     _send_data();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               // Profile Picture
//               CircleAvatar(
//                 radius: 80,
//                 backgroundImage: NetworkImage(photo_),
//                 backgroundColor: Colors.grey[200],
//               ),
//               const SizedBox(height: 20),
//
//               // Profile Information
//               Card(
//                 elevation: 8,
//                 margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildProfileDetail('Name', name_),
//                       _buildProfileDetail('Email', email_),
//                       _buildProfileDetail('Phone', phone_),
//                       _buildProfileDetail('Place', place_),
//                       _buildProfileDetail('City', city_),
//                       _buildProfileDetail('PIN', pin_),
//                       _buildProfileDetail('State', state_),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Edit Profile Button
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => user_edit_profile(title: "Edit Profile")));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                   primary: Theme.of(context).colorScheme.primary,
//                   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 child: const Text('Edit Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String name_ = "";
//   String photo_ = "";
//   String email_ = "";
//   String phone_ = "";
//   String place_ = "";
//   String state_ = "";
//   String city_ = "";
//   String pin_ = "";
//
//   // Helper function to build profile details in a neat way
//   Widget _buildProfileDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _send_data() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String img = sh.getString('img_url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/User_view_profile_usr/');
//     try {
//       final response = await http.post(urls, body: {'lid': lid});
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String name = jsonDecode(response.body)['name'];
//           String photo = img + jsonDecode(response.body)['photo'];
//           String email = jsonDecode(response.body)['email'];
//           String phone = jsonDecode(response.body)['phone'];
//           String place = jsonDecode(response.body)['place'];
//           String state = jsonDecode(response.body)['state'];
//           String city = jsonDecode(response.body)['city'];
//           String pin = jsonDecode(response.body)['pin'];
//
//           setState(() {
//             name_ = name;
//             photo_ = photo;
//             email_ = email;
//             phone_ = phone;
//             place_ = place;
//             state_ = state;
//             city_ = city;
//             pin_ = pin;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:roadmate/user/usr_edit_pofile.dart';
import 'package:roadmate/worker/wrkr_edit_pofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfileUsr(title: 'View Profile'),
    );
  }
}

class ViewProfileUsr extends StatefulWidget {
  const ViewProfileUsr({super.key, required this.title});

  final String title;

  @override
  State<ViewProfileUsr> createState() => _ViewProfileUsrState();
}

class _ViewProfileUsrState extends State<ViewProfileUsr> {

  @override
  void initState() {
    super.initState();
    _sendData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Profile Picture with border
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(photo_),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 20),

              // Profile Information Card
              Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildProfileDetail('Name', name_),
                        // _buildProfileDetail('Email', email_),
                        // _buildProfileDetail('Phone', phone_),
                        // _buildProfileDetail('Place', place_),
                        // _buildProfileDetail('City', city_),
                        // _buildProfileDetail('PIN', pin_),
                        // _buildProfileDetail('State', state_),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => user_edit_prof(title: "Edit Profile")));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  primary: Theme.of(context).colorScheme.onPrimary,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String name_ = "";
  String photo_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String state_ = "";
  String city_ = "";
  String pin_ = "";

  // Helper function to build profile details in a neat way
  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('img_url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_view_profile_usr/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String photo = img + jsonDecode(response.body)['photo'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String place = jsonDecode(response.body)['place'];
          String state = jsonDecode(response.body)['state'];
          String city = jsonDecode(response.body)['city'];
          String pin = jsonDecode(response.body)['pin'];

          setState(() {
            name_ = name;
            photo_ = photo;
            email_ = email;
            phone_ = phone;
            place_ = place;
            state_ = state;
            city_ = city;
            pin_ = pin;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
