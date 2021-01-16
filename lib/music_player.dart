import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class MusicPlayer extends StatefulWidget {
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<MusicPlayerState> key;
  MusicPlayer({this.songInfo, this.changeTrack, this.key}) : super(key: key);
  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  double mimimumValue = 0.0, maxmimunValue = 0.0, currentValue = 0.0;
  String currentTime = "", endTIme = "";
  bool isPlaying = false;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setSong(widget.songInfo);
  }

  void dispose() {
    super.dispose();
    player?.dispose();
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  void setSong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    currentValue = mimimumValue;
    maxmimunValue = player.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentValue);
      endTIme = getDuration(maxmimunValue);
    });
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((event) {
      currentValue = event.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentValue);
      });
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((e) => e.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_sharp),
            color: Colors.black),
        title: Text(
          "Now Playing",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Listen to your favourite music',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Center(
              child: Container(
                width: 280.0,
                height: 280.00,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: widget.songInfo.albumArtwork == null
                          ? AssetImage("assets/music_icon.jpg")
                          : File(widget.songInfo.albumArtwork).existsSync()
                              ? FileImage(File(widget.songInfo.albumArtwork))
                              : AssetImage("assets/music_icon.jpg"),
                    )),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                widget.songInfo.title,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                widget.songInfo.artist,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Slider(
              inactiveColor: Colors.grey,
              activeColor: Colors.white,
              min: mimimumValue,
              max: maxmimunValue,
              value: currentValue,
              onChanged: (value) {
                player.seek(Duration(milliseconds: value.round()));
              },
            ),
            Container(
              transform: Matrix4.translationValues(0, -7, 0),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentTime,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    endTIme,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.shuffle_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // widget.changeTrack(false);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 55,
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.changeTrack(false);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 75,
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      changeStatus();
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 55,
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.changeTrack(true);
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.repeat,
                      color: Colors.white,
                      size: 40,
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // widget.changeTrack(false);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
