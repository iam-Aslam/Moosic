// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import '../../../widgets/common.dart';

class MostPlayedPage extends StatefulWidget {
  const MostPlayedPage({super.key});

  @override
  State<MostPlayedPage> createState() => _MostPlayedPageState();
}

class _MostPlayedPageState extends State<MostPlayedPage> {
  var orientation, size, height, width;

  final box = MostplayedBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];

  @override
  void initState() {
    List<MostPlayed> mostsong = box.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayedsongs.insert(i, element);
        i++;
      }
    }
    for (var items in mostplayedsongs) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }

    super.initState();
  }

  List<MostPlayed> mostplayedsongs = [];
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;

    //size of the window
    size = MediaQuery.of(context).size;

    height = size.height;

    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: [
              Container(
                width: width / 1,
                height: height / 2.8,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/images/most.jpg',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.5),
                  child: Column(
                    children: [
                      titleslib(title: 'Most Played'),
                      // Expanded(
                      //   child: GridView.count(
                      //     shrinkWrap: true,
                      //     // physics: const NeverScrollableScrollPhysics(),
                      //     crossAxisCount: 2,
                      //     children: List.generate(
                      //       favorsong.length,
                      //       (index) => favoritedummy(
                      //           song: favorsong[index],
                      //           image: favorimg[index],
                      //           time: favortime[index]),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/arrowback.png'),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
