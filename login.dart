// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
// import 'package:roadmate/worker/wrkr_home.dart';
// import 'package:roadmate/worker/wrkr_signup.dart';
// import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:roadmate/user/user_home.dart';
// import 'package:roadmate/user/usr_signup.dart';
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
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Login(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class Login extends StatefulWidget {
//   const Login({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
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
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: username,
//                 decoration: InputDecoration(
//                     labelText: "username"
//                 ),),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: password,
//                 decoration: InputDecoration(labelText: "password"),
//               ),
//             ),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             },
//               child:Text("Login"),),
//
//               ElevatedButton(onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(
//                       builder: (context) => mysSignup(),));
//               }, child:Text("Worker signup"),
//
//
//               ),
//
//             ElevatedButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => user_signup(),));
//             }, child:Text("User signup"),
//
//
//             )
//
//           ],
//         ),),
//
//     );
//   }
//
//   void _send_data() async{
//
//
//     String uname=username.text;
//     String _password=password.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/flut_login_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'name':uname,
//         'password':_password,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           String lid=jsonDecode(response.body)['lid'];
//           String type=jsonDecode(response.body)['type'];
//
//           if(type=="worker"){
//             sh.setString("lid", lid);
//             Fluttertoast.showToast(msg: "worker login successfull");
//
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomeScreen1(),));
//
//
//             // Navigator.push(context, MaterialPageRoute(
//             //   builder: (context) => wrkr_home(title: "Home"),));
//           }
//           else if(type=="user"){
//             sh.setString("lid", lid);
//
//             // Navigator.push(context, MaterialPageRoute(
//             //   builder: (context) => new_user_home(title: "Home"),));
//             //
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomeScreen(),));
//
//
//
//           }
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
// }
