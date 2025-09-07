import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/lgn/login_screen.dart';
import 'package:roadmate/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nss App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const passwordechange(title: 'Welcome to Nss app '),
    );
  }
}

class passwordechange extends StatefulWidget {
  const passwordechange({super.key, required this.title});

  final String title;

  @override
  State<passwordechange> createState() => _passwordechangeState();
}

class _passwordechangeState extends State<passwordechange> {

  TextEditingController currentp = new TextEditingController();
  TextEditingController newp = new TextEditingController();
  TextEditingController confirmp = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Current Password TextField
                _buildPasswordField('Current Password', currentp),

                // New Password TextField
                _buildPasswordField('New Password', newp),

                // Confirm Password TextField
                _buildPasswordField('Confirm Password', confirmp),

                // Change Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add password validation before navigating
                      if (newp.text != confirmp.text) {
                        // Show error if passwords don't match
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Passwords do not match!'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      // Navigate to the login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      // Send data function here
                      _send_data();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Button background color
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Change Password"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),





    );
  }

  void _send_data() async{

    String cp=currentp.text;
    String np=newp.text;
    String c_p=confirmp.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/passwordusr_post/');
    try {
      final response = await http.post(urls, body: {
        'cp':cp,
        'np':np,
        'c_p':c_p,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          // String lid=jsonDecode(response.body)['lid'];
          // sh.setString("lid", lid);
          Fluttertoast.showToast(msg: 'password changed successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginScreen(),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Widget _buildPasswordField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black), // Label color
          filled: true,
          fillColor: Colors.deepPurpleAccent.withOpacity(0.2), // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurpleAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pinkAccent),
          ),
        ),
      ),
    );
  }

}