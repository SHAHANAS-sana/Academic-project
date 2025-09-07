// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo', debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const EvPaymentHistory(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class EvPaymentHistory extends StatefulWidget {
//   const EvPaymentHistory({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<EvPaymentHistory> createState() => _EvPaymentHistoryState();
// }
//
// class _EvPaymentHistoryState extends State<EvPaymentHistory> {
//   _EvPaymentHistoryState() {
//     viewNotification();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> payment_ = <String>[];
//   List<String> slotno_ = <String>[];
//   List<String> amount_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> phone_ = <String>[];
//   List<String> place_ = <String>[];
//   List<String> latitude_ = <String>[];
//   List<String> longitude_ = <String>[];
//   List<String> state_ = <String>[];
//   List<String> city_ = <String>[];
//   List<String> pin_ = <String>[];
//
//   Future<void> viewNotification() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> payment = <String>[];
//     List<String> slotno = <String>[];
//     List<String> amount = <String>[];
//     List<String> name = <String>[];
//     List<String> phone = <String>[];
//     List<String> place = <String>[];
//     List<String> latitude = <String>[];
//     List<String> longitude = <String>[];
//     List<String> state = <String>[];
//     List<String> city = <String>[];
//     List<String> pin = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       String url = '$urls/view_payment_ev_history/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         "lid": lid,
//       });
//
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         payment.add(arr[i]['payment'].toString());
//         slotno.add(arr[i]['slotno'].toString());
//         amount.add(arr[i]['amount'].toString());
//         name.add(arr[i]['name'].toString());
//         phone.add(arr[i]['phone'].toString());
//         place.add(arr[i]['place'].toString());
//         latitude.add(arr[i]['latitude'].toString());
//         longitude.add(arr[i]['longitude'].toString());
//         state.add(arr[i]['state'].toString());
//         city.add(arr[i]['city'].toString());
//         pin.add(arr[i]['pin'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         payment_ = payment;
//         slotno_ = slotno;
//         amount_ = amount;
//         name_ = name;
//         phone_ = phone;
//         place_ = place;
//         latitude_ = latitude;
//         longitude_ = longitude;
//         state_ = state;
//         city_ = city;
//         pin_ = pin;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//             child: Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Date: ${date_[index]}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text('Payment: ${payment_[index]}'),
//                     Text('Slot No: ${slotno_[index]}'),
//                     Text('Amount: ${amount_[index]}'),
//                     Text('Name: ${name_[index]}'),
//                     Text('Phone: ${phone_[index]}'),
//                     Text('Place: ${place_[index]}'),
//                     Text('Latitude: ${latitude_[index]}'),
//                     Text('Longitude: ${longitude_[index]}'),
//                     Text('State: ${state_[index]}'),
//                     Text('City: ${city_[index]}'),
//                     Text('Pin: ${pin_[index]}'),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // ElevatedButton(
//                         //   onPressed: () async {
//                         //     // Add your action here, for example, show more details
//                         //   },
//                         //   style: ElevatedButton.styleFrom(
//                         //     primary: Theme.of(context).colorScheme.onPrimary,
//                         //   ),
//                         //   child: Text("View Details"),
//                         // ),
//                         // IconButton(
//                         //   icon: Icon(Icons.phone),
//                         //   onPressed: () {
//                         //     // Add action to make a call
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
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
      home: const EvPaymentHistory(title: 'Payment History'),
    );
  }
}

class EvPaymentHistory extends StatefulWidget {
  const EvPaymentHistory({super.key, required this.title});

  final String title;

  @override
  State<EvPaymentHistory> createState() => _EvPaymentHistoryState();
}

class _EvPaymentHistoryState extends State<EvPaymentHistory> {
  _EvPaymentHistoryState() {
    viewNotification();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> payment_ = <String>[];
  List<String> slotno_ = <String>[];
  List<String> amount_ = <String>[];
  List<String> name_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];
  List<String> latitude_ = <String>[];
  List<String> longitude_ = <String>[];
  List<String> state_ = <String>[];
  List<String> city_ = <String>[];
  List<String> pin_ = <String>[];

  Future<void> viewNotification() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> payment = <String>[];
    List<String> slotno = <String>[];
    List<String> amount = <String>[];
    List<String> name = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> latitude = <String>[];
    List<String> longitude = <String>[];
    List<String> state = <String>[];
    List<String> city = <String>[];
    List<String> pin = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      String url = '$urls/view_payment_ev_history/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        payment.add(arr[i]['payment'].toString());
        slotno.add(arr[i]['slotno'].toString());
        amount.add(arr[i]['amount'].toString());
        name.add(arr[i]['name'].toString());
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place'].toString());
        latitude.add(arr[i]['latitude'].toString());
        longitude.add(arr[i]['longitude'].toString());
        state.add(arr[i]['state'].toString());
        city.add(arr[i]['city'].toString());
        pin.add(arr[i]['pin'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        payment_ = payment;
        slotno_ = slotno;
        amount_ = amount;
        name_ = name;
        phone_ = phone;
        place_ = place;
        latitude_ = latitude;
        longitude_ = longitude;
        state_ = state;
        city_ = city;
        pin_ = pin;
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displaying Date
                    Text(
                      'Date: ${date_[index]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Displaying Payment and Amount
                    Text(
                      'Payment: ${payment_[index]}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      'Amount: ₹${amount_[index]}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Other information like Slot No, Name, etc.
                    Text('Slot No: ${slotno_[index]}'),
                    Text('Name: ${name_[index]}'),
                    Text('Phone: ${phone_[index]}'),
                    Text('Place: ${place_[index]}'),
                    Text('Latitude: ${latitude_[index]}'),
                    Text('Longitude: ${longitude_[index]}'),
                    Text('State: ${state_[index]}'),
                    Text('City: ${city_[index]}'),
                    Text('Pin: ${pin_[index]}'),

                    SizedBox(height: 12),

                    // Action buttons/icons (optional)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.phone, color: Colors.blue),
                        //   onPressed: () {
                        //     // Call action
                        //   },
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Add your action here, for example, show more details
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.deepPurple,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        //   child: Text("View Details"),
                        // ),
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
