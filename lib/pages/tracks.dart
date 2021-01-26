import 'package:MusicApp/cmps/audio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Tracks extends StatefulWidget {
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final controller = ScrollController();
  List<SongInfo> songs = [];

  @override
  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
    print(songs[0]);
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
            songs: songs,
          ),
        ),
      ),
    );
  }
}
