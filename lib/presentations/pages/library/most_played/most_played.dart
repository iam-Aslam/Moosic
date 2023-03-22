import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import '../../../widgets/common.dart';

class MostPlayedPage extends StatefulWidget {
  const MostPlayedPage({super.key});

  @override
  State<MostPlayedPage> createState() => _MostPlayedPageState();
}

class _MostPlayedPageState extends State<MostPlayedPage> {
  // ignore: prefer_typing_uninitialized_variables
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
              SizedBox(
                width: width / 1,
                height: height / 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.5),
                  child: Column(
                    children: [
                      titleslib(title: 'Most Played'),
                      ValueListenableBuilder<Box<MostPlayed>>(
                        valueListenable: box.listenable(),
                        builder: (context, value, child) {
                          return mostplayedsongs.isNotEmpty
                              ? Expanded(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    children: List.generate(
                                      mostplayedsongs.length,
                                      (index) => favoritedummy(
                                          audioplayer: audioPlayer,
                                          recentsongs: songs,
                                          index: index,
                                          context: context,
                                          song: mostplayedsongs[index].songname,
                                          image: mostplayedsongs[index].id,
                                          time:
                                              mostplayedsongs[index].duration),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Your most played songs will appear here!",
                                    style:
                                        GoogleFonts.kanit(color: Colors.black),
                                  ),
                                );
                        },
                      )
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
