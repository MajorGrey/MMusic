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
    return SafeArea(
      child: Container(
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          radius: Radius.circular(3.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                      focusColor: Colors.grey,
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
                        padding: EdgeInsets.fromLTRB(12, 10, 0, 2),
                        child: Row(
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: widget.songs[index].albumArtwork ==
                                            null
                                        ? AssetImage("assets/music_icon.jpg")
                                        : File(widget.songs[index].albumArtwork)
                                                .existsSync()
                                            ? FileImage(File(widget
                                                .songs[index].albumArtwork))
                                            : AssetImage(
                                                "assets/music_icon.jpg"),
                                  )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 8.0, 8.0, 8.0),
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 0, 13.0, 8.0),
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: widget.songs.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
