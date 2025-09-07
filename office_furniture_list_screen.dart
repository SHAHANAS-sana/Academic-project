import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/lgn/login_screen.dart';
import 'package:roadmate/login.dart';
import 'package:roadmate/user/add_reminder.dart';
import 'package:roadmate/user/chat%20bot.dart';
import 'package:roadmate/user/ev_payment_history.dart';
import 'package:roadmate/user/fuelpredictionbasedondataset.dart';
import 'package:roadmate/user/history.dart';
import 'package:roadmate/user/request_ev.dart';
import 'package:roadmate/user/send_complaint.dart';
import 'package:roadmate/user/send_review.dart';
import 'package:roadmate/user/view_booking.dart';
import 'package:roadmate/user/view_complaint.dart';
import 'package:roadmate/user/view_evpoint.dart';
import 'package:roadmate/user/view_fuelreq_status.dart';
import 'package:roadmate/user/view_near_by_station.dart';
import 'package:roadmate/user/view_nearby_wrkr.dart';
import 'package:roadmate/user/view_previous_booking.dart';
import 'package:roadmate/user/view_reminder.dart';
import 'package:roadmate/user/view_req_service_status.dart';
import 'package:roadmate/user/wrkr_payment_history.dart';
import 'package:roadmate/user_home/core/app_data.dart';
import 'package:roadmate/user_home/core/app_style.dart';
import 'package:roadmate/user_home/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OfficeFurnitureListScreen extends StatefulWidget {
  const OfficeFurnitureListScreen({super.key});

  @override
  State<OfficeFurnitureListScreen> createState() =>
      _OfficeFurnitureListScreen_state();
}

class _OfficeFurnitureListScreen_state extends State<OfficeFurnitureListScreen> {
  _OfficeFurnitureListScreen_state() {
    _send_data();
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name_, style: h2Style),
                  Text("Welcome to Roadmate", style: h3Style),
                ],
              ),
              IconButton(
                onPressed: () {
                  // Show a confirmation dialog before navigating to the login screen
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Log Out"),
                        content: const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // If the user clicks "Cancel", just close the dialog
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // If the user clicks "Log Out", navigate to the login screen
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: const Text("Log Out"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout),
              )

            ],
          ),
        ),
      ),
    );
  }

  // Widget _searchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 15),
  //     child: TextField(
  //       decoration: InputDecoration(
  //         hintText: 'Search',
  //         prefixIcon: const Icon(Icons.search, color: Colors.grey),
  //         suffixIcon: const Icon(Icons.menu, color: Colors.grey),
  //         contentPadding: const EdgeInsets.all(20),
  //         border: textFieldStyle,
  //         focusedBorder: textFieldStyle,
  //       ),
  //     ),
  //   );
  // }

  // Function to navigate to different pages based on the item tapped
  void navigateToPage(String furnitureName) {

    print(furnitureName);
    print("hello");
    switch (furnitureName) {

      case 'Ev Stations':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>view_EV_usr(title:"view ev point")));
        break;
      case 'FuelHub':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>view_nearby_fuel_station(title: "view fuelstation")));

        break;
      case 'WorkZone':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>nearby_wrkr(title: "view worker")));

        break;
      case 'BookView':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>view_booking(title:"view booking")));

        break;
      case 'Book Hist':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>history_usr(title:"booking history")));

        break;

      case 'PrevBook ':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>previous_bookings(title:"previous booking")));
        break;

      case 'ServStatus':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_req_service_status(title:"view req")));

        break;

      case 'EV Status':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_req_service_status_ev(title:"view req ev")));

        break;

      case 'Fuel Status':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_fuel_req_status(title:"view req fuel staff")));

        break;

      case 'EVPay Hist':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EvPaymentHistory(title:"ev payment history")));

        break;

      case 'WrkrPayHist':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_payment_history(title:"worker payment history")));

        break;

      case 'Reminde':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddReminder(title:"add reminder")));

        break;

      case 'RemindView':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewReminder(title:"view reminder")));

        break;

      case 'Send Comp':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SendComplaintScreen(title: "send complaint")));

        break;

      case 'View Comp':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewComplaintScreen(title: "View complaint")));

        break;

      case 'Chatbot':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(title: "Chatbot")));

        break;


      case 'Prediction':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PricePrediction(title: "Prediction")));

        break;


    // case 'Review':
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>send_review_usr(title: "send review")));
    //
    //   break;



    }
  }

  @override
  Widget build(BuildContext context) {
    // List of furniture names and images
    List<String> furnitureNames = [
      "Ev Stations",
      "FuelHub",
      "WorkZone",
      "BookView",
      "Book Hist",
      "PrevBook ",
      "ServStatus",
      "EV Status",
      "Fuel Status",
      "EVPay Hist",
      "WrkrPayHist",
      "Reminde",
      "RemindView",
      "Send Comp",
      "View Comp",
      "Chatbot",
      "Prediction",
      // "Review",


    ];

    // List of images (make sure the images exist in your assets folder)
    List<String> furnitureImages = [
      'assets/images/ev.jpg',
      'assets/images/fuel.jpg',
      'assets/images/wrk.jpeg',
      'assets/images/view booking.webp',
      'assets/images/bookhis.jpg',
      'assets/images/bookhis.jpg',
      'assets/images/servicereq.jpg',
      'assets/images/evstatus.jpg',
      'assets/images/fuelstatus.jpg',
      'assets/images/evpay.jpg',
      'assets/images/wrkrpayhis.jpg',
      'assets/images/addrim.jpg',
      'assets/images/viewrim.jpg',
      'assets/images/sndcomplaint.jpg',
      'assets/images/sendcmplt.jpg',
      'assets/images/chatbot.jpeg',
      'assets/images/prediction.jpeg',
    ];

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            // _searchBar(),
            const Text("Popular", style: h2Style),
            // GridView of cards
            GridView.builder(
              shrinkWrap: true,  // To allow scrolling with the ListView
              physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,  // 2 columns per row
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.0, // Adjust the aspect ratio as needed
              ),
              itemCount: 17, // Display 6 cards
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the corresponding page
                    navigateToPage(furnitureNames[index]);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(furnitureImages[index]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            furnitureNames[index], // Display the name of the furniture
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
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

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('img_url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/User_view_profile_usr/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });
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

// Individual Pages for each furniture item

class ExecutiveDeskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Executive Desk")),
      body: Center(child: Text("Details about Executive Desk")),
    );
  }
}

class ModernOfficeChairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modern Office Chair")),
      body: Center(child: Text("Details about Modern Office Chair")),
    );
  }
}

class AdjustableStandingDeskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adjustable Standing Desk")),
      body: Center(child: Text("Details about Adjustable Standing Desk")),
    );
  }
}

class ConferenceTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conference Table")),
      body: Center(child: Text("Details about Conference Table")),
    );
  }
}

class BookshelfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookshelf")),
      body: Center(child: Text("Details about Bookshelf")),
    );
  }
}

class OfficeLoungeChairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Office Lounge Chair")),
      body: Center(child: Text("Details about Office Lounge Chair")),
    );
  }
}
