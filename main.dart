import 'package:flutter/material.dart';
import 'package:roadmate/lgn/login_screen.dart';
// import 'package:roadmate/lgn/login_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Screen ",
      home: LoginScreen(),
    ),
  );
}