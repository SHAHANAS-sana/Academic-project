import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/worker/wrkr_view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyEditPage(title: 'Edit Profile'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  _MyEditPageState() {
    _get_data();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pin = TextEditingController();
  String photo = '';

  File? _selectedImage;
  String? _encodedImage;

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/view_profile_wrkr/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String photo_ = img + jsonDecode(response.body)['photo'];
          String email = jsonDecode(response.body)['email'];
          String phone_ = jsonDecode(response.body)['phone'];
          String place_ = jsonDecode(response.body)['place'];
          String state_ = jsonDecode(response.body)['state'];
          String city_ = jsonDecode(response.body)['city'];
          String pin_ = jsonDecode(response.body)['pin'];

          nameController.text = name;
          emailController.text = email;
          phone.text = phone_;
          place.text = place_;
          state.text = state_;
          city.text = city_;
          pin.text = pin_;

          setState(() {
            photo = photo_;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Profile Image Section with shadow effect
                if (_selectedImage != null)
                  InkWell(
                    onTap: _chooseAndUploadImage,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(_selectedImage!),
                      backgroundColor: Colors.transparent,
                    ),
                  )
                else
                  InkWell(
                    onTap: _chooseAndUploadImage,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(photo),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Select Image',
                          style: TextStyle(color: Colors.cyan, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                // Text Fields
                _buildTextField(nameController, 'Full Name'),
                _buildTextField(emailController, 'Email Address'),
                _buildTextField(phone, 'Phone Number'),
                _buildTextField(place, 'Place of Residence'),
                _buildTextField(state, 'State'),
                _buildTextField(city, 'City'),
                _buildTextField(pin, 'Pin Code'),
                const SizedBox(height: 20),
                // Confirm Edit Button with rounded borders and shadow
                ElevatedButton(
                  onPressed: _send_data,
                  child: const Text("Confirm Edit"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.black,
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextField with modern styling and icon
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.deepPurple),
          prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    String sname = nameController.text;
    String semail = emailController.text;
    String sphone = phone.text;
    String splace = place.text;
    String state_ = state.text;
    String city_ = city.text;
    String pin_ = pin.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/editprofilewrk_post/');
    try {
      final response = await http.post(urls, body: {
        "photo": photo,
        "name": sname,
        "em": semail,
        "phn": sphone,
        "plc": splace,
        "state": state_,
        "city": city_,
        "pin": pin_,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => worker_profile(title: "Profile")),
          );
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

  // Function to pick and upload the image
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }
}
