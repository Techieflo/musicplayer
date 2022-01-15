import 'dart:io';
import 'package:music/constants.dart';
import 'package:music/helpers/textwidget.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:music/main.dart';
import 'package:music/screens/allmusic.dart';

class Nowplaying extends StatefulWidget {
  double size;
  SongInfo songinfo;
  List songs;
  Function changeTrack;
  Nowplaying(
      {required Key key,
      required this.size,
      required this.changeTrack,
      required this.songinfo,
      required this.songs})
      : super(key: key);

  @override
  State<Nowplaying> createState() => NowplayingState();
}

class NowplayingState extends State<Nowplaying> {
  Icon customIcon = const Icon(Icons.search);
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
    audiomanagerinstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audiomanagerinstance.position.inMilliseconds /
              audiomanagerinstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isplaying = audiomanagerinstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audiomanagerinstance.position.inMilliseconds /
              audiomanagerinstance.duration.inMilliseconds;
          audiomanagerinstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audiomanagerinstance.next();

          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_drop_down_sharp),
      //     color: Colors.deepPurple,
      //     onPressed: () {
      //       Navigator.pop();
      //     },
      //   ),
      // ),
      body: Center(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(5, 57, 5, 0),
          child: Column(children: [
            SizedBox(
              height: widget.size.toDouble(),
            ),
            Container(
              color: Colors.white,
              height: 60,
            ),
            CircleAvatar(
              backgroundImage: widget.songinfo.albumArtwork == null
                  ? const AssetImage("assets/images/ui.png")
                  : FileImage(File(widget.songinfo.albumArtwork))
                      as ImageProvider,
              radius: 75,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: text(
                widget.songinfo.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 33),
              child: text(
                widget.songinfo.artist,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Slider(
              inactiveColor: Colors.black26,
              activeColor: Colors.deepPurple,
              value: _slider,
              onChanged: (value) {
                setState(() {
                  _slider = value;
                });
              },
              onChangeEnd: (value) {
                if (audiomanagerinstance.duration != null) {
                  Duration msec = Duration(
                      milliseconds:
                          (audiomanagerinstance.duration.inMilliseconds * value)
                              .round());
                  audiomanagerinstance.seekTo(msec);
                }
              },
            ),
            Container(
              transform: Matrix4.translationValues(0, -15, 0),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_fduration(audiomanagerinstance.position),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500)),
                  Text(_fduration(audiomanagerinstance.duration),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.skip_previous,
                        color: Colors.deepPurple, size: 55),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      audiomanagerinstance.previous();
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                        audiomanagerinstance.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        color: Colors.deepPurple,
                        size: 85),
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      audiomanagerinstance.playOrPause();
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.skip_next,
                        color: Colors.deepPurple, size: 55),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      audiomanagerinstance.next();
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

var audiomanagerinstance = AudioManager.instance;
PlayMode playmode = audiomanagerinstance.playMode;
bool isplaying = false;
bool next = false;
double _slider = 0.0;
bool showvol = false;
String _fduration(Duration d) {
  if (d == null) return "--/--";
  int minute = d.inMinutes;
  int seconds = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? '0$minute' : '$minute') +
      ":" +
      ((seconds < 10) ? "0$seconds" : "$seconds");
  return format;
}
