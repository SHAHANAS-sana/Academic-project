import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:roadmate/user/usr_edit_pofile.dart';
import 'package:roadmate/worker/wrkr_edit_pofile.dart';
import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
  // Declare variables to hold user profile data
  String name_ = "";
  String photo_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String state_ = "";
  String city_ = "";
  String pin_ = "";

  @override
  void initState() {
    super.initState();
    _send_data(); // Fetch user data when the screen is initialized
  }

  // Function to fetch user profile data
  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('img_url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_profile_wrkr/');
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

  // Function to handle "Edit Profile" button press
  void _editProfile() {
    // Navigate to the Edit Profile screen (you can implement this screen later)
    Fluttertoast.showToast(msg: "Edit Profile button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen1(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0, // Makes the app bar transparent
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture at the top
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: photo_.isNotEmpty
                            ? Image.network(
                          photo_,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.account_circle,
                          size: 120,
                          color: Colors.grey,
                        ), // Default icon if no photo
                      ),
                      const SizedBox(height: 16),

                      // Name in a Row format
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel("Name"),
                          Text(
                            name_.isNotEmpty ? name_ : 'Loading...',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Email in a Row format
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel("Email"),
                          Text(
                            email_.isNotEmpty ? email_ : 'Loading...',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Phone in a Row format
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel("Phone"),
                          Text(
                            phone_.isNotEmpty ? phone_ : 'Loading...',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Address in a Row format
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel("Address"),
                          Text(
                            place_.isNotEmpty
                                ? '$place_, $state_, $city_, $pin_'
                                : 'Loading...',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Edit Profile Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyEditPage(title: "Edit Profile"),
                            ),
                          );
                        },
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded button
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to create label widget
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }
}
