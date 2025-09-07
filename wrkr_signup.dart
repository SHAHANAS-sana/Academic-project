import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadmate/lgn/login_screen.dart';
import 'package:roadmate/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(sSignup());
}

class sSignup extends StatelessWidget {
  const sSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: mysSignup(),
    );
  }
}

class mysSignup extends StatefulWidget {
  const mysSignup({super.key});

  @override
  State<mysSignup> createState() => _mysSignupState();
}

class _mysSignupState extends State<mysSignup> {

  // validation

  final _formcontrol = GlobalKey<FormState>();

  // gender--
  // String gender = "Male";

  // courese add if you want
  // String? _selectedCourse;

  // final List<String> _course = ['BSC CS', 'BCA', 'B-COM', 'BBA', 'M-COM', 'MSC-CS', 'MCA',];

  // String? _semester;

  // final List<String> _sem = ['1','2','3','4','5','6'];


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController place=TextEditingController();
  TextEditingController latitude=TextEditingController();
  TextEditingController longitude=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController pin=TextEditingController();
  TextEditingController status=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController cpassword=TextEditingController();

  // calender view

  // final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  //
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       dob.text = _dateFormatter.format(picked);
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Signup"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formcontrol,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if(_selectedImage!=null) ...{
                  InkWell(
                    child: Image.file(_selectedImage!, height: 400,),
                    radius: 399,
                    onTap: _chooseAndUploadImage,
                  )
                }else ...{
                  InkWell(
                    onTap: _chooseAndUploadImage,
                    child: Column(
                      children: [
                        Image(image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                          height: 200,
                          width: 200,),
                        Text('Select Image', style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },
                Padding(padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "please fill the name ";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: ("Name")),
                  ),),
                // Padding(padding: const EdgeInsets.all(8),
                // child: TextFormField(
                //   validator: (value){
                //     if(value!.isEmpty){
                //       return "please fill the name ";
                //     }
                //     return null;
                //   },
                //   onTap:(){
                //     _selectDate(context);
                //   },
                //   controller: dob,
                //   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Dob")),
                // ),),
                // RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";});},title: Text("Male"),),
                // RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";});},title: Text("Female"),),
                // RadioListTile(value: "Other", groupValue: gender, onChanged: (value) {setState(() {gender="Other";});},title: Text("Other"),),
                //
                Padding(
                  padding:const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      // } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                      //   return 'Please enter a valid email address';
                      }
                      return null; // Return null if validation passes
                    },
                    controller: emailController,
                    decoration: InputDecoration(border: OutlineInputBorder(),label:Text("Email")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null; // Return null if validation passes
                    },
                    controller: phone,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "please fill the place ";
                      }
                      return null;
                    },
                    controller: place,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "please fill the state ";
                      }
                      return null;
                    },
                    controller: state,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("State")),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "please fill the city ";
                      }
                      return null;
                    },
                    controller: city,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: ("City")),
                  ),),
                Padding(padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "please fill the pin ";
                      }
                      return null;
                    },
                    controller: pin,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: ("Pin")),
                  ),),
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: TextFormField(
                //     validator: (value){
                //       if(value!.isEmpty){
                //         return "please fill the name ";
                //       }
                //       return null;
                //     },
                //     controller: semester,
                //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Semester")),
                //   ),
                // ),
                // Padding(padding: const EdgeInsets.all(8),
                //   child: DropdownButtonFormField<String>(
                //     decoration: InputDecoration(
                //       labelText: 'Semester',
                //       border: OutlineInputBorder(),
                //     ),
                //     validator: (value){
                //       if(value == null || value.isEmpty){
                //         return "please select a bloodgroup";
                //       }
                //       return null;
                //     },
                //     value: _semester,
                //     items: _sem.map((String group) {
                //       return DropdownMenuItem<String>(
                //         value: group,
                //         child: Text(group),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _semester = newValue;
                //       });
                //     },
                //   ),
                // ),
                // Padding(padding: const EdgeInsets.all(8),
                //   child: DropdownButtonFormField<String>(
                //     decoration: InputDecoration(
                //       labelText: 'Course',
                //       border: OutlineInputBorder(),
                //     ),
                //     validator: (value){
                //       if(value == null || value.isEmpty){
                //         return "please select a bloodgroup";
                //       }
                //       return null;
                //     },
                //     value: _selectedCourse,
                //     items: _course.map((String group) {
                //       return DropdownMenuItem<String>(
                //         value: group,
                //         child: Text(group),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _selectedCourse = newValue;
                //       });
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return "please enter a password ";
                      }
                      return null;
                    },
                    controller:password,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please confirm the password";
                      }
                      if (value != password.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    controller:cpassword,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm password")),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formcontrol.currentState!.validate()){
                      _signupdata();
                    }// _signupdata();
                  },
                  child: Text("Signup"),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text("Login")
                ),
              ],

            ),
          ),
        ),
      ),

    );
  }


  void _signupdata()async{

    String sname=nameController.text;
    // String sdob=dob.text;
    String semail=emailController.text;
    String sphone=phone.text;
    String splace=place.text;
    String state_=state.text;
    String city_=city.text;
    String pin_=pin.text;
    String spassword=password.text;
    String scpassword=cpassword.text;

    SharedPreferences sh = await SharedPreferences.getInstance();

    String url = sh.getString('url').toString();

    final urls = Uri.parse("$url/signupwrk_post/");

    try{
      final response = await http.post(urls,body: {

        "photo":photo,
        // "idproof":photo2,
        // "gender":gender,
        "name":sname,
        // "dob":sdob,/
        "em":semail,
        "phn":sphone,
        "plc":splace,
        "state":state_,
        "city":city_,
        "pin":pin_,
        "pwd":spassword,
        "cpwd":scpassword,

      });

      print(response);
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'signup  Successfull');
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginScreen()));
        } else {
          Fluttertoast.showToast(msg: 'email already exists');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }




  File? _selectedImage;
  String? _encodedImage;
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

  // Future<void> _checkPermissionAndChooseImage() async {
  //   final PermissionStatus status = await Permission.mediaLibrary.request();
  //   if (status.isGranted) {
  //     _chooseAndUploadImage();
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: const Text('Permission Denied'),
  //         content: const Text(
  //           'Please go to app settings and grant permission to choose an image.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  String photo = '';


}


