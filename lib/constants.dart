import 'package:flutter_audio_query/flutter_audio_query.dart';

String artist = '';
String stitle = '';
List<SongInfo> songinfo = [];

void getsongs() async {
  songinfo =
      await FlutterAudioQuery().getSongs(sortType: SongSortType.DISPLAY_NAME);
  songinfo = songinfo;
}
