import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16, color: Colors.black),
          bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
          headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
      ),
      home: user_payment_page(),
    );
  }
}

class user_payment_page extends StatefulWidget {
  @override
  _user_payment_pageState createState() => _user_payment_pageState();
}

class _user_payment_pageState extends State<user_payment_page> {
  late Razorpay _razorpay;
  int amnt = 0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _loadAmount();
  }

  _loadAmount() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    amnt = int.parse(sh.getString("amount").toString());
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String bid = sh.getString('id').toString();

    final urls = Uri.parse('$url/user_ev_payment/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'bid': bid,
        'pay': "300",
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Payment successful");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Fluttertoast.showToast(msg: 'Payment not found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName}");
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': 300 * 100, // Amount in paisa
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {'wallets': ['paytm']} // List of external wallets
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Complete Your Payment',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),

              // Amount
              Text(
                'Total Amount: ₹$amnt',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),

              // Payment Button
              ElevatedButton.icon(
                onPressed: _openCheckout,
                icon: Icon(Icons.payment, size: 20),
                label: Text(
                  'Proceed to Payment',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 30),

              // Powered by Razorpay
              Text(
                'Powered by Razorpay',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
