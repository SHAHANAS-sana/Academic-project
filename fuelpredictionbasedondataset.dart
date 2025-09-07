import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petrol Price Prediction',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black.withOpacity(0.7)),
        ),
      ),
      home: const PricePrediction(title: 'Submit a Complaint'),
    );
  }
}

class PricePrediction extends StatefulWidget {
  const PricePrediction({super.key, required this.title});

  final String title;

  @override
  State<PricePrediction> createState() => _PricePredictionState();
}

class _PricePredictionState extends State<PricePrediction> {
  String price = "";

_PricePredictionState(){
  _sendData();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Circular container for price display
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                child: Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 32), // Space below the circular container
              // You can add more widgets here if necessary.
            ],
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/petrolpriceprediction/');

    try {
      final response = await http.post(urls, body: {
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String data = jsonDecode(response.body)['data'].toString();
          print(data);
          print("hhhhhh");
          setState(() {

            price = data;


          });
        } else {
          Fluttertoast.showToast(msg: 'Failed to fetch price');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
