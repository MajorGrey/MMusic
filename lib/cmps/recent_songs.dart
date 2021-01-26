import "package:flutter/material.dart";

class RecentSongs extends StatefulWidget {
  @override
  _RecentSongsState createState() => _RecentSongsState();
}

class _RecentSongsState extends State<RecentSongs> {
  @override
  Widget build(BuildContext context) {
    return SliverList();
  }
}

// erro() {
//   return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Newest Songs',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w900)),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           height: 150.0,
//                           width: 250.0,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               image: DecorationImage(
//                                 image: AssetImage("assets/music_icon.jpg"),
//                               )),
//                         ),
//                       ],
//                     ),
//                     Text('Your Favourite Songs',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w900)),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           height: 150.0,
//                           width: 150.0,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               image: DecorationImage(
//                                 image: AssetImage("assets/music_icon.jpg"),
//                               )),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30.0,
//                     ),
//                     Text('Recently Played',
//                         style: TextStyle(
//                             fontSize: 25.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w900)),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           height: 150.0,
//                           width: 150.0,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0),
//                               image: DecorationImage(
//                                 image: AssetImage("assets/music_icon.jpg"),
//                               )),
//                         ),
//                     );

// }
