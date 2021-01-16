import 'dart:io';
import 'package:MusicApp/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioLists extends StatefulWidget {
  final List<SongInfo> songs;
  AudioLists({this.songs});
  @override
  _AudioListsState createState() => _AudioListsState();
}

class _AudioListsState extends State<AudioLists> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  int CurrentIndex = 0;
  int _currentNav = 0;

  void changeTrack(bool isNext) {
    if (isNext) {
      if (CurrentIndex != widget.songs.length - 1) {
        CurrentIndex++;
      }
    } else {
      if (CurrentIndex != 0) {
        CurrentIndex--;
      }
    }
    key.currentState.setSong(widget.songs[CurrentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        radius: Radius.circular(3.0),
        child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    CurrentIndex = index;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MusicPlayer(
                              changeTrack: changeTrack,
                              songInfo: widget.songs[CurrentIndex],
                              key: key,
                            )));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: widget.songs[index].albumArtwork == null
                                    ? AssetImage("assets/music_icon.jpg")
                                    : File(widget.songs[index].albumArtwork)
                                            .existsSync()
                                        ? FileImage(File(
                                            widget.songs[index].albumArtwork))
                                        : AssetImage("assets/music_icon.jpg"),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.songs[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.songs[index].artist,
                                  style: TextStyle(color: Colors.white60),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: widget.songs.length),
      ),
    );
  }
}
