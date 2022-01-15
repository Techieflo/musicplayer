import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

final TextEditingController searchcontroller = TextEditingController();

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<SongInfo> _song = [];
  int currentIndex = 0;
  void getsongs() async {
    _song = await FlutterAudioQuery()
        .getSongs(sortType: SongSortType.ALPHABETIC_ALBUM);
    setState(() {
      _song = _song;
    });
  }

  List Searchresult = [];

  searchoperation(String searchtext) {
    Searchresult.clear();
    for (int i = 0; i < _song.length; i++) {
      String data = _song[i].artist;
      print(data);
      if (data.toLowerCase().contains(searchtext.toLowerCase())) {
        Searchresult.add(data);
        print(Searchresult);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            child: TextField(
              autofocus: true,
              controller: searchcontroller,
              style: const TextStyle(color: Colors.deepPurple),
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
                hintText: 'Enter Query here',
                hintStyle: const TextStyle(color: Colors.deepPurple),
              ),
              onChanged: searchoperation(searchcontroller.text),
            ),
          ),
        ],
      ),
    );
  }
}
