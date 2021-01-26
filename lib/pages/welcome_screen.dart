import 'dart:async';
import 'package:MusicApp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  getPermission() async {
    print('Hello');
    if (await Permission.storage.request().isGranted) {
      var a = await Permission.storage.status;
      print(a);

      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ));
    }
    // if (await Permission.storage.isPermanentlyDenied) {
    //   openAppSettings();
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note_outlined,
                size: 40.0,
                color: Colors.green,
              ),
              Text(
                'MMusic',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
