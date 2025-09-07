import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddReminder(title: 'Add Reminder'),
    );
  }
}

class AddReminder extends StatefulWidget {
  const AddReminder({super.key, required this.title});

  final String title;

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  TextEditingController dateController = TextEditingController();
  TextEditingController reminderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Date Field
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Enter Date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 16),

              // Reminder Field
              TextField(
                controller: reminderController,
                decoration: InputDecoration(
                  labelText: "Enter Reminder",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(Icons.note),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 32),

              // Send Button
              ElevatedButton(
                onPressed: _sendData,
                child: Text("Send Reminder"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    String date = dateController.text;
    String reminder = reminderController.text;
    if (date.isEmpty || reminder.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/add_reminder/');
    try {
      final response = await http.post(urls, body: {
        'reminder': reminder,
        'date': date,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Reminder sent successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Fluttertoast.showToast(msg: 'Failed to send reminder');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
