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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff000000),
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
      ),
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
                color: Colors.green,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.music_note,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.music_note,
                color: Colors.deepPurple,
              ),
              title: Text("Music")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.folder_open,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.indigo,
              ),
              title: Text("Folders")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.green,
              ),
              title: Text("Menu"))
        ],
      ),
    );
  }
}
