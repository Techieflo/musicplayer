import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:music/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music/screens/about.dart';
import 'package:music/screens/allmusic.dart';
import 'package:music/screens/nowplaying.dart';
import 'package:music/screens/search.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Aillmusic(),
    );
  }
}

var audiomanagerinstance = AudioManager.instance;
PlayMode playmode = audiomanagerinstance.playMode;
bool isplaying = false;
double _slider = 0.0;
bool showvol = false;

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var _currentIndex = 1;
//   final List<Widget> _bottomoptions = <Widget>[
//     // Nowplaying(
//     //   size: 0,
//     // ),
//     const Aillmusic(),
//     const Aillmusic(),
//     const Search(),
//     const About()
//   ];

//   final List<String> _title = [
//     'Now Playing',
//     'Music List',
//     'Search',
//     'About',
//   ];
//   final List<Color> _color = [
//     Colors.white,
//     Colors.deepPurple,
//     Colors.deepPurple,
//     Colors.deepPurple
//   ];
//   final List<Color> _tcolor = [
//     Colors.deepPurple,
//     Colors.white,
//     Colors.white,
//     Colors.white,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: _color.elementAt(_currentIndex),
//         title: Text(
//           _title.elementAt(_currentIndex),
//           style: TextStyle(color: _tcolor[_currentIndex]),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Nowplaying(
//                               size: 60,
//                               songinfo: ,
//                             )));
//               },
//               child: Column(
//                 children: const [
//                   Icon(
//                     Icons.volume_down,
//                     size: 20,
//                   ),
//                   Text('Now Playing')
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       bottomNavigationBar: SalomonBottomBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         items: [
//           /// Home
//           SalomonBottomBarItem(
//             icon: Icon(Icons.music_note),
//             title: Text("Now Playing"),
//             unselectedColor: Colors.deepPurple,
//             selectedColor: Colors.deepPurple,
//           ),

//           /// Likes
//           SalomonBottomBarItem(
//             icon: Icon(Icons.album),
//             title: Text("All Songs"),
//             unselectedColor: Colors.deepPurple,
//             selectedColor: Colors.deepPurple,
//           ),

//           /// Search
//           SalomonBottomBarItem(
//             icon: Icon(Icons.search),
//             title: Text("Search"),
//             unselectedColor: Colors.deepPurple,
//             selectedColor: Colors.deepPurple,
//           ),

//           /// Profile
//           SalomonBottomBarItem(
//             icon: const Icon(
//               Icons.info_outline,
//             ),
//             title: const Text("About Us"),
//             unselectedColor: Colors.deepPurple,
//             selectedColor: Colors.deepPurple,
//           ),
//         ],
//       ),
//       body: _bottomoptions[_currentIndex],
//     );
//   }
// }
