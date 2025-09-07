import 'package:flutter/material.dart';
import 'package:roadmate/lgn/login_screen.dart';
import 'package:roadmate/login.dart';

import 'package:roadmate/user_home/core/app_style.dart';
import 'package:roadmate/worker/wrkr_add_service.dart';
import 'package:roadmate/worker/wrkr_approved_req_service.dart';
import 'package:roadmate/worker/wrkr_rejected_req_service.dart';
import 'package:roadmate/worker/wrkr_view_payment.dart';
import 'package:roadmate/worker/wrkr_view_service.dart';
import 'package:roadmate/worker/wrkr_view_service_req.dart';


class OfficeFurnitureListScreen1 extends StatefulWidget {
  const OfficeFurnitureListScreen1({super.key});

  @override
  State<OfficeFurnitureListScreen1> createState() =>
      _OfficeFurnitureListScreen1_state();
}

class _OfficeFurnitureListScreen1_state extends State<OfficeFurnitureListScreen1> {


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
                  Text("Worker", style: h2Style),
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
    switch (furnitureName) {
      // case 'Ev Stations':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>view_EV_usr(title:"view ev point")));
      //   break;
      // case 'Fuel Stations':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>view_nearby_fuel_station(title: "view fuelstation")));
      //
      //   break;
      // case 'Work Stations':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>nearby_wrkr(title: "view worker")));
      //
      //   break;
      // case 'View Booking':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>view_booking(title:"view booking")));
      //
      //   break;
      // case 'Slot Booking History':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>history_usr(title:"booking history")));
      //
      //   break;
      // case 'Previous Booking History':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>previous_bookings(title:"previous booking")));
      //
      //   break;
      //
      // case 'View Request Service Status':
      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_req_service_status(title:"view req")));
      //
      //   break;

      case 'Add Service':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddService(title: "add service")));

        break;

      case 'View Service':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WrkrViewService(title: "view service")));

        break;

      case 'View servreq':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_service_req(title:"view service request")));

        break;

      case 'Approved Service':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_approved_req(title:"view approved service request")));

        break;

      case 'Rejected Service':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>wrkr_view_rejected_req(title:"view rejected service request")));

        break;

      case 'Payment':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>view_payment_wrkr(title:"view payment")));
        break;


      //
      // case 'Send Complaint':
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>sendcomplaint(title: "send complaint")));
      //
      //   break;
      //
      // case 'Send Complaint':
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>view_complaint(title: "View complaint")));
      //
      //   break;
      //   case 'View Complaint':
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>view_complaint(title: "View complaint")));
      //
      //   break;

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
      "Add Service",
      "View Service",
      "View servreq",
      "Approved Service",
      "Rejected Service",
      "Payment",
      // "Previous Booking History",
      // "View Request Service Status",
      // "View Request EV Status",
      // "View Request Fuel Status",
      // "View EV Payment History",
      // "View Worker Payment History",
      // "Add Reminder",
      // "View Reminder",
      // "Send Complaint",
      // "View Complaint",
      // "Review",


    ];

    // List of images (make sure the images exist in your assets folder)
    List<String> furnitureImages = [
      'assets/images/addservice.jpg',
      'assets/images/viewservice.jpg',
      'assets/images/Paymentwrk.jpg',
      'assets/images/approve.jpg',
      'assets/images/reject.jpg',
      'assets/images/Paymentwrk.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
      // 'assets/furniture_5.jpg',
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
                crossAxisCount: 2,  // 2 columns per row
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.0, // Adjust the aspect ratio as needed
              ),
              itemCount: 6, // Display 6 cards
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

  // String name_ = "";
  // String photo_ = "";
  // String email_ = "";
  // String phone_ = "";
  // String place_ = "";
  // String state_ = "";
  // String city_ = "";
  // String pin_ = "";

  // void _send_data() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString('url').toString();
  //   String img = sh.getString('img_url').toString();
  //   String lid = sh.getString('lid').toString();
  //
  //   final urls = Uri.parse('$url/User_view_profile_usr/');
  //   try {
  //     final response = await http.post(urls, body: {
  //       'lid': lid
  //     });
  //     if (response.statusCode == 200) {
  //       String status = jsonDecode(response.body)['status'];
  //       if (status == 'ok') {
  //         String name = jsonDecode(response.body)['name'];
  //         String photo = img + jsonDecode(response.body)['photo'];
  //         String email = jsonDecode(response.body)['email'];
  //         String phone = jsonDecode(response.body)['phone'];
  //         String place = jsonDecode(response.body)['place'];
  //         String state = jsonDecode(response.body)['state'];
  //         String city = jsonDecode(response.body)['city'];
  //         String pin = jsonDecode(response.body)['pin'];
  //         setState(() {
  //           name_ = name;
  //           photo_ = photo;
  //           email_ = email;
  //           phone_ = phone;
  //           place_ = place;
  //           state_ = state;
  //           city_ = city;
  //           pin_ = pin;
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: 'Not Found');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Network Error');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }
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
