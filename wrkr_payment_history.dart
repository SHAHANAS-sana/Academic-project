import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Payment History',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const wrkr_payment_history(title: 'Payment History'),
    );
  }
}

class wrkr_payment_history extends StatefulWidget {
  const wrkr_payment_history({super.key, required this.title});
  final String title;

  @override
  State<wrkr_payment_history> createState() => _wrkr_payment_historyState();
}

class _wrkr_payment_historyState extends State<wrkr_payment_history> {

  _wrkr_payment_historyState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> payment_ = <String>[];
  List<String> phone_= <String>[];
  List<String> place_ = <String>[];
  List<String> latitude_ = <String>[];
  List<String> longtitude_= <String>[];
  List<String> state_ = <String>[];
  List<String> city_= <String>[];
  List<String> pin_ = <String>[];
  List<String> servicename_ = <String>[];
  List<String> serviceamount_ = <String>[];
  List<String> description_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> payment = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> latitude = <String>[];
    List<String> longtitude = <String>[];
    List<String> state = <String>[];
    List<String> city = <String>[];
    List<String> pin = <String>[];
    List<String> servicename = <String>[];
    List<String> serviceamount = <String>[];
    List<String> description = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      String url = '$urls/view_payment_wrkr_history/';

      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        payment.add(arr[i]['payment'].toString());
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place'].toString());
        latitude.add(arr[i]['latitude'].toString());
        longtitude.add(arr[i]['longtitude'].toString());
        state.add(arr[i]['state'].toString());
        city.add(arr[i]['city'].toString());
        pin.add(arr[i]['pin'].toString());
        servicename.add(arr[i]['servicename'].toString());
        serviceamount.add(arr[i]['serviceamount'].toString());
        description.add(arr[i]['description'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        payment_ = payment;
        phone_ = phone;
        place_= place;
        latitude_= latitude;
        longtitude_= longtitude;
        state_= state;
        city_= city;
        pin_= pin;
        servicename_= servicename;
        serviceamount_= serviceamount;
        description_= description;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.all(8),
              color: Colors.white,
              shadowColor: Colors.black.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Info Section
                    _buildSectionTitle('Payment Details'),
                    _buildRow('Payment Date:', date_[index]),
                    _buildRow('Payment Status:', payment_[index]),
                    _buildRow('Phone:', phone_[index]),
                    _buildRow('Place:', place_[index]),
                    _buildRow('Latitude:', latitude_[index]),
                    _buildRow('Longitude:', longtitude_[index]),
                    SizedBox(height: 16),

                    // Service Info Section
                    _buildSectionTitle('Service Details'),
                    _buildRow('Service Name:', servicename_[index]),
                    _buildRow('Service Amount:', '₹${serviceamount_[index]}'),
                    _buildRow('Description:', description_[index]),
                    SizedBox(height: 16),

                    // Location Info Section
                    _buildSectionTitle('Location Details'),
                    _buildRow('State:', state_[index]),
                    _buildRow('City:', city_[index]),
                    _buildRow('Pin:', pin_[index]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method for creating a row with label and value
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 24, color: Colors.deepPurple),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label $value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for creating section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
