// ignore_for_file: use_build_context_synchronously, camel_case_types
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final box = SongBox.getInstance();
  final mostbox = MostplayedBox.getInstance();
  List<SongModel> fetchSongs = [];
  List<SongModel> allSongs = [];

  @override
  void initState() {
    goHome();
    requestStoragepermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 92, 46, 216),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/images/splash.png'),
                  height: 350,
                  width: 350,
                ),
              ]),
        ),
      ),
    ));
  }

  Future<void> goHome() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.of(context).pushReplacementNamed('home');
  }

  //request permission function
  Future<void> requestStoragepermission() async {
    // only if platform
    if (!kIsWeb) {
      //check if not permission status
      bool status = await _audioQuery.permissionsStatus();
      //request if not permission status
      if (!status) {
        await _audioQuery.permissionsRequest();
      }
      fetchSongs = await _audioQuery.querySongs();
      for (var i in fetchSongs) {
        if (i.fileExtension == "mp3") {
          allSongs.add(i);
        }
      }
      for (var i in allSongs) {
        await box.add(Songs(
            artist: i.artist,
            duration: i.duration,
            id: i.id,
            songurl: i.uri,
            songname: i.title));
      }
      for (var items in allSongs) {
        mostbox.add(MostPlayed(
            songname: items.title,
            songurl: items.uri!,
            duration: items.duration!,
            artist: items.artist!,
            count: 0,
            id: items.id));
      }
    }
  }
}
