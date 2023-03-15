// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/pages/current_playing/current.dart';
import 'package:moosic/presentations/pages/favorites/favorites.dart';
import 'package:moosic/presentations/pages/home/songs.dart';
import 'package:moosic/presentations/pages/library/library.dart';
import 'package:moosic/presentations/pages/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class home extends StatefulWidget {
  const home({super.key});

  static int? index = 0;
  static ValueNotifier<int> currentvalue = ValueNotifier<int>(index!);

  @override
  State<home> createState() => _homeState();
}

final audioPlayer = AssetsAudioPlayer.withId('0');
// getting songs from databas by creating its object
final box = SongBox.getInstance();
List<Audio> convertAudios = [];

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  late AnimationController iconcontroller;
  bool isAnimated = false;
  bool isplaying = false;
  int currentselected = 0;
  final pages = const [
    songs(),
    favorites(),
    libraries(),
    settings(),
  ];
  @override
  void initState() {
    List<Songs> dbsongs = box.values.toList();
    for (var i in dbsongs) {
      convertAudios.add(Audio.file(
        i.songurl!,
        metas: Metas(
          title: i.songname,
          artist: i.artist,
          id: i.id.toString(),
        ),
      ));
    }
    audioPlayer.open(
        Playlist(
          audios: convertAudios,
        ),
        showNotification: true,
        autoStart: false);

    iconcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    iconcontroller.forward();
    iconcontroller.reverse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    //size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
        child: Scaffold(
      body: pages[currentselected],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: currentselected,
          onTap: (value) => setState(() {
            currentselected = value;
          }),
          height: 60,
          buttonBackgroundColor: Colors.deepPurpleAccent,
          color: Colors.deepPurpleAccent,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.favorite,
              size: 30,
            ),
            Icon(
              Icons.library_music,
              size: 30,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: ValueListenableBuilder(
          valueListenable: home.currentvalue,
          builder: (BuildContext context, int value, child) {
            return ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box<Songs> allsongs, child) {
                List<Songs> alldbsongs = allsongs.values.toList();
                return InkWell(
                  onTap: () {
                    log('hi aslam.... i am miniplayer');
                    current.currentvalue.value = value;
                    Navigator.of(context).pushNamed('current');
                  },
                  child: Container(
                    height: height / 14,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 18,
                        ),
                        QueryArtworkWidget(
                          quality: 100,
                          artworkWidth: width / 6.5,
                          artworkHeight: height / 13.5,
                          keepOldArtwork: true,
                          artworkBorder: BorderRadius.circular(30),
                          id: alldbsongs[value].id!,
                          type: ArtworkType.AUDIO,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width / 3,
                              //color: Colors.amberAccent,
                              child: Text(
                                alldbsongs[value].songname!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width / 3,
                              //color: Colors.amberAccent,
                              child: Text(
                                alldbsongs[value].artist!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            log('hi i am previous');
                            previous(player, value, alldbsongs);
                          },
                          icon: const Icon(
                            Icons.skip_previous_outlined,
                            color: Colors.deepPurpleAccent,
                            size: 36,
                          ),
                        ),
                        //play button from slider
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (context, isPlaying) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   isAnimated = !isAnimated;
                                      //   if (isAnimated) {
                                      //     iconcontroller.forward();
                                      //     audioPlayer.play();
                                      //   } else {
                                      //     iconcontroller.reverse();
                                      //     audioPlayer.pause();
                                      //   }
                                      // });
                                      setState(() {
                                        isAnimated = !isAnimated;
                                        if (isAnimated) {
                                          iconcontroller.forward();
                                          playbutton(
                                              audioPlayer, value, alldbsongs);
                                        } else {
                                          iconcontroller.reverse();
                                          player.stop();
                                        }
                                      });
                                    },
                                    child: AnimatedIcon(
                                        icon: AnimatedIcons.play_pause,
                                        size: 36,
                                        color: Colors.deepPurpleAccent,
                                        progress: iconcontroller),
                                  ),
                                ],
                              );
                            }),

                        IconButton(
                          onPressed: () {
                            log('hi i am next');
                            next(player, value, alldbsongs);
                          },
                          icon: const Icon(
                            Icons.skip_next_outlined,
                            color: Colors.deepPurpleAccent,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ));
  }

  void playbutton(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    player.open(
      Audio.file(dbsongs[index].songurl!),
      showNotification: true,
    );
    setState(() {
      home.currentvalue.value;
    });
    await player.stop();
  }

  void previous(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    player.open(
      Audio.file(dbsongs[index - 1].songurl!),
      showNotification: true,
    );
    setState(() {
      home.currentvalue.value--;
    });
    await player.stop();
  }

  void next(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    player.open(
      Audio.file(dbsongs[index + 1].songurl!),
      showNotification: true,
    );
    setState(() {
      home.currentvalue.value++;
    });
    await player.stop();
  }
}
