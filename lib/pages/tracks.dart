import 'package:MusicApp/cmps/audio_list.dart';
import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Tracks extends StatefulWidget {
  final songs;
  Tracks({this.songs});
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller, // Note the controller here
        title: Row(
          children: [
            Icon(
              Icons.music_note_outlined,
              color: Colors.green,
            ),
            Text(
              "MMusic",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Will make background transparent
        materialType: MaterialType
            .transparency, // Needed if you want a transparent background
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: AudioLists(
            songs: widget.songs,
          ),
        ),
      ),
    );
  }
}
