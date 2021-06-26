import 'dart:async';
import 'dart:convert';
import 'package:MusicApp/pages/homepage.dart';
import 'package:MusicApp/pages/tracks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:MusicApp/database.dart";

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final db = Db();
  @override
  void initState() {
    super.initState();
    getPermission();
    getSongs();
  }

  Future getSongs() async {
    List songs = await audioQuery.getSongs();
    // print(songs);
    saveSongs(songs);

    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Tracks()),
            ));
  }

  saveSongs(songs) async {
    // var d = Db(
    //   id: 1,
    //   name: 'all_songs',
    //   value: songs,
    // );
    // await db.insert(d);
    // var p = await db.datas();
    // var r = p[1].value;
    // var o = jsonDecode(r);
    // print(o);
    print(songs);
  }

  getPermission() async {
    if (await Permission.storage.request().isGranted) {
      var a = await Permission.storage.status;
      print(a);
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
