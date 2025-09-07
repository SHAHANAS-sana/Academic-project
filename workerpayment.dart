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
      debugShowCheckedModeBanner: false,
      home: user_worker_payment_page(),
    );
  }
}

class user_worker_payment_page extends StatefulWidget {
  @override
  _user_worker_payment_pageState createState() =>
      _user_worker_payment_pageState();
}

class _user_worker_payment_pageState extends State<user_worker_payment_page> {
  late Razorpay _razorpay;
  int amnt = 0;

  @override
  void initState() {
    super.initState();

    // Initializing Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    a();
  }

  a() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    amnt = int.parse(sh.getString("amount").toString());
  }

  @override
  void dispose() {
    // Disposing Razorpay instance to avoid memory leaks
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle successful payment
    print("Payment Successful: ${response.paymentId}");

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String sid = sh.getString('id').toString();
    String amount = sh.getString('amount').toString();
    amnt = int.parse(amount);

    final urls = Uri.parse('$url/user_wrkr_payment/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'sid': sid,
        'pay': amount,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Payment Successful");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
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

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': amnt * 100,
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
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
        title: Text('Make Payment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Complete Your Payment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            // Description
            Text(
              'Please proceed with the payment to complete your transaction. The amount due is ₹$amnt.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 40),

            // Payment Button
            ElevatedButton(
              onPressed: _openCheckout,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text(
                'Make Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
