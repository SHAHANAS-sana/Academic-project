//
//
//
// import 'package:flutter/material.dart';
// import 'package:roadmate/login.dart';
// import 'package:roadmate/worker/wrkr_add_service.dart';
// import 'package:roadmate/worker/wrkr_approved_req_service.dart';
// import 'package:roadmate/worker/wrkr_passwordchange.dart';
// import 'package:roadmate/worker/wrkr_rejected_req_service.dart';
// import 'package:roadmate/worker/wrkr_view_payment.dart';
// import 'package:roadmate/worker/wrkr_view_profile.dart';
// import 'package:roadmate/worker/wrkr_view_review.dart';
// import 'package:roadmate/worker/wrkr_view_service.dart';
// import 'package:roadmate/worker/wrkr_view_service_req.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//       title: 'Nss App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const wrkr_home(title: 'Welcome to Nss app '),
//     );
//   }
// }
//
// class wrkr_home extends StatefulWidget {
//   const wrkr_home({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<wrkr_home> createState() => _wrkr_homeState();
// }
//
// class _wrkr_homeState extends State<wrkr_home> {
//
//   TextEditingController ipc = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Drawer(
//
//         child: ListView(
// // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Drawer Header'),
//             ),
//             ListTile(
//               title: const Text('View service'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_service(title: "view service")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('Add service'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>add_service(title: "add service")));
//
//
//               },
//             ),
//
//             ListTile(
//               title: const Text('View profile'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>worker_profile(title: "Profile")));
//
//               },
//             ),
//
//             ListTile(
//               title: const Text('Approved request service'),
//               onTap: () {
//                 // wrkr_view_approved_req
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_approved_req(title:"view approved service request")));
//               },
//             ),
//             ListTile(
//               title: const Text('Rejected  request service'),
//               onTap: () {
//                 // wrkr_view_rejected_req
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_rejected_req(title:"view rejected service request")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('View payment'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_payment_wrkr(title:"view payment")));
//
//               },
//             ),
//             // ListTile(
//             //   title: const Text('View review'),
//             //   onTap: () {
//             //     // wrkr_view_review
//             //     Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_review(title:"view review")));
//             //
//             //   },
//             // ),
//             ListTile(
//               title: const Text('View service request'),
//               onTap: () {
//                 // wrkr_view_service_req
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_service_req(title:"view service request")));
//               },
//             ),
//             ListTile(
//               title: const Text('Password change'),
//               onTap: () {
//
//
//                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>passwordechange(title: "passwordechange")));
//
//
//               },
//             ),
//           ],
//         ),
//       )
//     );
//   }
//
//
// }
//
//
//
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
