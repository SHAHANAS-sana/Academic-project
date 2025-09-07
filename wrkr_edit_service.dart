import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/worker/wrkr_home.dart';
import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const edit_service(title: 'Flutter Demo Home Page'),
    );
  }
}

class edit_service extends StatefulWidget {
  const edit_service({super.key, required this.title});


  final String title;

  @override
  State<edit_service> createState() => _edit_serviceState();
}

class _edit_serviceState extends State<edit_service> {
  TextEditingController servicename_ = TextEditingController();
  TextEditingController serviceamount_ = TextEditingController();
  TextEditingController descripton_ = TextEditingController();
  TextEditingController id_ = TextEditingController();
  _edit_serviceState(){
    _get_data();
  }

  void _get_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img = sh.getString('img_url').toString();
    String id = sh.getString('sid').toString();

    final urls = Uri.parse('$url/edit_service/');
    try {
      final response = await http.post(urls, body: {
        'id':id
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String id=jsonDecode(response.body)['id'].toString();
          String servicename=jsonDecode(response.body)['servicename'].toString();
          String serviceamount=jsonDecode(response.body)['serviceamount'].toString();
          String description=jsonDecode(response.body)['description'].toString();

          servicename_.text=servicename;
          serviceamount_.text=serviceamount;
          descripton_.text=description;
          id_.text=id;

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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: servicename_,
                decoration: InputDecoration(
                    labelText: "Service Name"
                ),),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: serviceamount_,
                decoration: InputDecoration(
                    labelText: "Service Amount"
                ),),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: descripton_,
                decoration: InputDecoration(
                    labelText: "Description"
                ),),
            ),
            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text("Edit service"))

          ],
        ),),

    );
  }
  void _send_data() async{
    String sn=servicename_.text;
    String sa=serviceamount_.text;
    String d=descripton_.text;
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String id = sh.getString('sid').toString();

    final urls = Uri.parse('$url/editservice_post/');
    try {
      final response = await http.post(urls, body: {
        'sn':sn,
        'sa':sa,
        'd':d,
        'id':id,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          // String lid=jsonDecode(response.body)['lid'];
          //   sh.setString("lid", lid);
          Fluttertoast.showToast(msg: "worker add service    successfull");

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen1(),));
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
}
