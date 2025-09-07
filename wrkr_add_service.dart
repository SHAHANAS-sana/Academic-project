// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:roadmate/worker/wrkr_home.dart';
// import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const add_service(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class add_service extends StatefulWidget {
//   const add_service({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<add_service> createState() => _add_serviceState();
// }
//
// class _add_serviceState extends State<add_service> {
//   TextEditingController servicename = TextEditingController();
//   TextEditingController serviceamount = TextEditingController();
//   TextEditingController descripton = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             Padding(padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: servicename,
//                 decoration: InputDecoration(
//                     labelText: "Service Name"
//                 ),),
//             ),
//             Padding(padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: serviceamount,
//                 decoration: InputDecoration(
//                     labelText: "Service Amount"
//                 ),),
//             ),
//             Padding(padding: EdgeInsets.all(8),
//               child: TextFormField(
//                 controller: descripton,
//                 decoration: InputDecoration(
//                     labelText: "Description"
//                 ),),
//             ),
//             ElevatedButton(onPressed: (){
//               _send_data();
//             }, child: Text("Add Service"))
//
//           ],
//         ),),
//
//     );
//   }
//
//
//   void _send_data() async{
//
//
//     String sn=servicename.text;
//     String sa=serviceamount.text;
//     String d=descripton.text;
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/addservice_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'sn':sn,
//         'sa':sa,
//         'd':d,
//         'lid':lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           // String lid=jsonDecode(response.body)['lid'];
//           //   sh.setString("lid", lid);
//             Fluttertoast.showToast(msg: "worker add service    successfull");
//
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => HomeScreen1(),));
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
//
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadmate/worker_home/src/view/screen/home_screen.dart';
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
      title: 'Add Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddService(title: 'Add Service'),
    );
  }
}

class AddService extends StatefulWidget {
  const AddService({super.key, required this.title});

  final String title;

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  TextEditingController servicename = TextEditingController();
  TextEditingController serviceamount = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Service Name field
                _buildTextField(servicename, "Service Name", Icons.business),

                // Service Amount field
                _buildTextField(serviceamount, "Service Amount", Icons.monetization_on),

                // Description field
                _buildTextField(description, "Description", Icons.description),

                // Add Service Button
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    primary: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Add Service", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  void _sendData() async {
    String sn = servicename.text;
    String sa = serviceamount.text;
    String d = description.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/addservice_post/');
    try {
      final response = await http.post(urls, body: {
        'sn': sn,
        'sa': sa,
        'd': d,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: "Service added successfully!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen1()),
          );
        } else {
          Fluttertoast.showToast(msg: 'Failed to add service.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
