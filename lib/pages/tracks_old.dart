import 'package:MusicApp/cmps/audio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Tracks extends StatefulWidget {
  // final songs;
  // Tracks({this.songs});
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  final controller = ScrollController();
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List songs;
  @override
  void initState() {
    super.initState();
    // getSongs();
  }

  Future getSongs() async {
    songs = await audioQuery.getSongs();
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shuffle_outlined), onPressed: () {}),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // brightness: Brightness.dark,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note_outlined,
                color: Colors.green,
              ),
              Text(
                'MMusic',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        // width: 48.0,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: FutureBuilder(
            future: getSongs(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return AudioLists(
                    songs: data,
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
