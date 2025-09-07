// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:roadmate/user/user_home.dart';
// import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
// import 'package:roadmate/worker/wrkr_home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
//       home: const send_review_usr(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class send_review_usr extends StatefulWidget {
//   const send_review_usr({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<send_review_usr> createState() => _send_review_usrState();
// }
//
// class _send_review_usrState extends State<send_review_usr> {
//   TextEditingController review = TextEditingController();
//   TextEditingController rating = TextEditingController();
//
//
//   String ratings="";
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
//                 controller: review,
//                 decoration: InputDecoration(
//                     labelText: "review"
//                 ),),
//             ),
//
//
//         RatingBar.builder(
//           initialRating: 3,
//           minRating: 1,
//           direction: Axis.horizontal,
//           allowHalfRating: true,
//           itemCount: 5,
//           itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//           itemBuilder: (context, _) => Icon(
//             Icons.star,
//             color: Colors.amber,
//           ),
//           onRatingUpdate: (rating) {
//             print(rating);
//
//             ratings=rating.toString();
//           },
//         ),
//
//
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text("Send"))
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
//     String rev=review.text;
//     String rat=rating.text;
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/User_send_review/');
//     try {
//       final response = await http.post(urls, body: {
//         'review':rev,
//         'rating':ratings,
//         'lid':lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           // String lid=jsonDecode(response.body)['lid'];
//           //   sh.setString("lid", lid);
//             Fluttertoast.showToast(msg: "Rating send   successfull");
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
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/user/user_home.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SendReviewUsr(title: 'Send Review'),
    );
  }
}

class SendReviewUsr extends StatefulWidget {
  const SendReviewUsr({super.key, required this.title});

  final String title;

  @override
  State<SendReviewUsr> createState() => _SendReviewUsrState();
}

class _SendReviewUsrState extends State<SendReviewUsr> {
  TextEditingController reviewController = TextEditingController();
  String ratings = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Review TextField
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Write your review",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Rating Bar
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratings = rating.toString();
                  });
                },
              ),

              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  _sendData();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text("Send Review"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    String reviewText = reviewController.text;

    if (reviewText.isEmpty || ratings.isEmpty) {
      Fluttertoast.showToast(msg: 'Please provide both review and rating');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = prefs.getString('url') ?? '';
    String lid = prefs.getString('lid') ?? '';

    final urlString = Uri.parse('$url/User_send_review/');
    try {
      final response = await http.post(urlString, body: {
        'review': reviewText,
        'rating': ratings,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Rating sent successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Fluttertoast.showToast(msg: 'Review submission failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

