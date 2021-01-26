import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:MusicApp/pages/home.dart';
import 'package:MusicApp/pages/tracks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;
  final List<Widget> _page = [Home(), Tracks()];

  void changePage(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _page[current_index],
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.black,
        opacity: .2,
        currentIndex: current_index,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        elevation: 8, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.grey, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.music_note,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              title: Text("Music", style: TextStyle(color: Colors.white))),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.folder_open,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.white,
              ),
              title: Text("Folders", style: TextStyle(color: Colors.white))),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              title: Text("Menu", style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
