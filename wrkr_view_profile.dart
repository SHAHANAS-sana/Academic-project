import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/worker/wrkr_edit_pofile.dart';
import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
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
      home: const worker_profile(title: 'View Profile'),
    );
  }
}

class worker_profile extends StatefulWidget {
  const worker_profile({super.key, required this.title});

  final String title;

  @override
  State<worker_profile> createState() => _worker_profileState();
}

class _worker_profileState extends State<worker_profile> {
  _worker_profileState() {
    _send_data();
  }

  String name_ = "";
  String photo_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String state_ = "";
  String city_ = "";
  String pin_ = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomeScreen1(),
              ));
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Profile Image and Info
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(photo_),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 16),
                // Profile Information in Card
                Card(
                  elevation: 8,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name_,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildProfileInfo("Email", email_),
                        _buildProfileInfo("Phone", phone_),
                        _buildProfileInfo("Place", place_),
                        _buildProfileInfo("City", city_),
                        _buildProfileInfo("Pin", pin_),
                        _buildProfileInfo("State", state_),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                    primary: Colors.deepPurple,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img = sh.getString('img_url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_profile_wrkr/');
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
