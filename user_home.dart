//
//
//
// import 'package:flutter/material.dart';
// import 'package:roadmate/login.dart';
// import 'package:roadmate/user/add_reminder.dart';
// import 'package:roadmate/user/ev_payment_history.dart';
// import 'package:roadmate/user/history.dart';
// import 'package:roadmate/user/request_ev.dart';
// import 'package:roadmate/user/send_review.dart';
// import 'package:roadmate/user/send_complaint.dart';
// import 'package:roadmate/user/usr_edit_pofile.dart';
// import 'package:roadmate/user/usr_passwordchange.dart';
// import 'package:roadmate/user/usr_signup.dart';
// import 'package:roadmate/user/usr_view_profile.dart';
// import 'package:roadmate/user/booking.dart';
// import 'package:roadmate/user/view_booking.dart';
// import 'package:roadmate/user/view_complaint.dart';
// import 'package:roadmate/user/view_evpoint.dart';
// import 'package:roadmate/user/view_fuelreq_status.dart';
// import 'package:roadmate/user/view_near_by_station.dart';
// import 'package:roadmate/user/view_nearby_wrkr.dart';
// import 'package:roadmate/user/view_previous_booking.dart';
// import 'package:roadmate/user/view_reminder.dart';
// import 'package:roadmate/user/view_req_service_status.dart';
// import 'package:roadmate/user/view_service.dart';
// import 'package:roadmate/user/view_slot.dart';
// import 'package:roadmate/user/view_stock.dart';
// import 'package:roadmate/user/wrkr_payment_history.dart';
//
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
//       home: const new_user_home(title: 'Welcome to Nss app '),
//     );
//   }
// }
//
// class new_user_home extends StatefulWidget {
//   const new_user_home({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<new_user_home> createState() => _new_user_homeState();
// }
//
// class _new_user_homeState extends State<new_user_home> {
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
//               title: const Text('Send complaint'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>sendcomplaint(title: "send complaint")));
//
//               },
//             ), ListTile(
//               title: const Text('View complaint'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_complaint(title: "View complaint")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('Send review'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>send_review_usr(title: "send review")));
//
//
//               },
//             ),
//
//
//
//             ListTile(
//               title: const Text('Change password'),
//               onTap: () {
//                 // wrkr_view_approved_req
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>passwordechange(title:"password change")));
//               },
//             ),
//
//             ListTile(
//               title: const Text('View profile'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_profile_usr(title:"view profile")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('View slot booking'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_booking(title:"view booking")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('View ev point'),
//               onTap: () {
//                 // wrkr_view_service_req
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_EV_usr(title:"view ev point")));
//               },
//             ),
//             ListTile(
//               title: const Text('View fuelstation'),
//               onTap: () {
//
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_nearby_fuel_station(title: "view fuelstation")));
//
//
//               },
//             ),
//             ListTile(
//               title: const Text('View worker'),
//               onTap: () {
//
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>nearby_wrkr(title: "view worker")));
//
//
//               },
//             ),
//
//             // ListTile(
//             //   title: const Text('View slot'),
//             //   onTap: () {
//             //
//             //
//             //     Navigator.push(context, MaterialPageRoute(builder: (context)=>view_slot_user(title: "view slot")));
//             //
//             //
//             //   },
//             // ),
//             // ListTile(
//             //   title: const Text('View stock'),
//             //   onTap: () {
//             //
//             //
//             //     Navigator.push(context, MaterialPageRoute(builder: (context)=>view_stock_usr(title: "view stock")));
//             //
//             //
//             //   },
//             // ),
//             ListTile(
//               title: const Text('slot booking history '),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>history_usr(title:"booking history")));
//
//               },
//             ),
//             ListTile(
//               title: const Text(' previous booking slot'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>previous_bookings(title:"previous booking")));
//
//               },
//             ),
//
//             ListTile(
//               title: const Text('view request wrkr'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_req_service_status(title:"view req")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('view request ev'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_req_service_status_ev(title:"view req ev")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('view request fuel'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_fuel_req_status(title:"view req fuel staff")));
//
//               },
//             ),
//
//
//             ListTile(
//               title: const Text('worker payment history'),
//               onTap: () {
//                 // user_view_fuel_req_status
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_payment_history(title:"worker payment history")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('ev payment history'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ev_payment_history(title:"ev payment history")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('add reminder'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>add_reminder(title:"add reminder")));
//
//               },
//             ),
//             ListTile(
//               title: const Text('view reminder'),
//               onTap: () {
//                 // wrkr_view_review
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_reminder(title:"view reminder")));
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
