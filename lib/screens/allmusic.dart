import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music/screens/about.dart';
import 'nowplaying.dart';
import 'package:music/screens/nowplaying.dart';
import 'package:music/screens/search.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Aillmusic extends StatefulWidget {
  const Aillmusic({Key? key}) : super(key: key);

  @override
  State<Aillmusic> createState() => _AillmusicState();
}

class _AillmusicState extends State<Aillmusic> {
  List<SongInfo> _song = [];
  int currentIndex = 0;
  final GlobalKey<NowplayingState> key = GlobalKey<NowplayingState>();
  void getsongs() async {
    _song = await FlutterAudioQuery()
        .getSongs(sortType: SongSortType.ALPHABETIC_ALBUM);
    setState(() {
      _song = _song;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != _song.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
  }

  @override
  void initState() {
    getsongs();
    super.initState();
  }

  var _currentIndex = 1;

  final List<String> _title = [
    'Now Playing',
    'Music List',
    'Search',
    'About',
  ];
  final List<Color> _color = [
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurple
  ];
  final List<Color> _tcolor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    Icon customIcon = const Icon(Icons.search);
    Widget customSearchBar = Container();
    final List _bottomoptions = [
      // Nowplaying(
      //   size: 0,
      // ),

      Nowplaying(
        size: 0,
        songinfo: _song[currentIndex],
        songs: _song,
        key: key,
        changeTrack: changeTrack,
      ),
      body2(),
      Search(),
      const About()
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _color.elementAt(_currentIndex),
        title: Text(
          _title.elementAt(_currentIndex),
          style: TextStyle(color: _tcolor[_currentIndex]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: _currentIndex == 1
                    ? const Icon(
                        Icons.search,
                        color: Colors.white,
                      )
                    : Container()),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.music_note),
            title: Text("Now Playing"),
            unselectedColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.album),
            title: Text("All Songs"),
            unselectedColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            unselectedColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.info_outline,
            ),
            title: const Text("About Us"),
            unselectedColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
          ),
        ],
      ),
      body: _bottomoptions[_currentIndex],
    );
  }

  StatelessWidget body2() {
    if (_song.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            audiomanagerinstance
                .start("file://${_song[index].filePath}", _song[index].title,
                    desc: "my Nusic player",
                    cover:
                        //
                        "assets/images/ui.png")
                .then((value) => print(value));

            currentIndex = index;
            setState(() {
              _currentIndex = 0;
            });
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Nowplaying(
            //               size: 100,
            //               songinfo: _song[currentIndex],
            //             )));
          },
          leading: CircleAvatar(
            backgroundImage: _song[index].albumArtwork == null
                ? const AssetImage("assets/images/ui.png")
                : FileImage(File(_song[index].albumArtwork)) as ImageProvider,
          ),
          title: Text(_song[index].title),
          subtitle: Text(_song[index].artist),
          trailing: const Icon(Icons.more_vert),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _song.length,
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 4,
              ),
              Text('Fetching music')
            ],
          ),
        ),
      );
    }
  }

// class Allmusic extends StatelessWidget {
//   const Allmusic({
//     Key? key,
//     required List<SongInfo> song,
//   })  : _song = song,
//         super(key: key);

//   final List<SongInfo> _song;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: _song.length == null
//               ? ListView.separated(
//                   itemBuilder: (context, index) => ListTile(
//                         onTap: () {
//                           audiomanagerinstance
//                               .start("file://${_song[index].filePath}",
//                                   _song[index].title,
//                                   desc: "my Nusic player",
//                                   cover: "assets/images/ui.png")
//                               .then((value) => print(value));
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Nowplaying(
//                                         size: 100,
//                                         songinfo: _song[index],
//                                       )));
//                         },
//                         leading: CircleAvatar(
//                           backgroundImage: _song[index].albumArtwork == null
//                               ? const AssetImage("assets/images/ui.png")
//                               : FileImage(File(_song[index].albumArtwork))
//                                   as ImageProvider,
//                         ),
//                         title: Text(_song[index].title),
//                         subtitle: Text(_song[index].artist),
//                         trailing: const Icon(Icons.more_vert),
//                       ),
//                   separatorBuilder: (context, index) => const Divider(),
//                   itemCount: _song.length)
//               : Container(
//                   height: MediaQuery.of(context).size.height,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         CircularProgressIndicator(),
//                         SizedBox(
//                           width: 4,
//                         ),
//                         Text('Fetching music')
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }
}
