// ignore_for_file: sized_box_for_whitespace, camel_case_types
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/pages/favorites/addtofavourite.dart';
import 'package:moosic/presentations/widgets/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

class current extends StatefulWidget {
  const current({super.key});

  static int? index = 0;
  static ValueNotifier<int> currentvalue = ValueNotifier<int>(index!);

  @override
  State<current> createState() => _currentState();
}

// ignore: prefer_typing_uninitialized_variables
var orientation, size, height, width;

class _currentState extends State<current> with SingleTickerProviderStateMixin {
  //AssetsAudioPlayer player = AssetsAudioPlayer();
  final player = AssetsAudioPlayer.withId('0');
  late AnimationController iconcontroller;
  bool isAnimated = false;
  final box = SongBox.getInstance();

  @override
  void initState() {
    // List<Songs> dbsongs = box.values.toList();
    iconcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    iconcontroller.forward();
    iconcontroller.reverse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getting the orientation of the app
    orientation = MediaQuery.of(context).orientation;
    //percentage indicator default value declarations
    Duration duration = Duration.zero;
    Duration position = Duration.zero;
    //size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: current.currentvalue,
              builder: (BuildContext context, int value, child) {
                return ValueListenableBuilder<Box<Songs>>(
                  valueListenable: box.listenable(),
                  builder: (BuildContext context, Box<Songs> allsongs, child) {
                    List<Songs> allDbdongs = allsongs.values.toList();

                    return player.builderCurrent(
                      builder: (context, playing) {
                        return Column(
                          children: [
                            QueryArtworkWidget(
                              quality: 100,
                              artworkQuality: FilterQuality.high,
                              artworkHeight: height / 1.68,
                              artworkWidth: width / 1,
                              artworkBorder: BorderRadius.circular(0),
                              artworkFit: BoxFit.cover,
                              id: allDbdongs[value].id!,
                              type: ArtworkType.AUDIO,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text(
                                          allDbdongs[value].songname!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.ebGaramond(
                                            textStyle: TextStyle(
                                                letterSpacing: .5,
                                                fontSize: width / 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (checkFavour(
                                                value, BuildContext)) {
                                              addfavour(value);
                                            } else if (!checkFavour(
                                                value, BuildContext)) {
                                              removefavour(value);
                                            }
                                            setState(() {});
                                          },
                                          icon: (checkFavour(
                                                  value, BuildContext))
                                              ? const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Text(
                                          allDbdongs[value].artist!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.ebGaramond(
                                            textStyle: TextStyle(
                                                letterSpacing: .5,
                                                fontSize: width / 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            log('i am add to playlist in current playing screen');
                                            showOptions(context, value);
                                          },
                                          icon: const Icon(
                                            Icons.playlist_add_circle_sharp,
                                            color: Colors.deepPurpleAccent,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height / 30,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Playing Next - ',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                letterSpacing: .5,
                                                fontSize: width / 25,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            allDbdongs[value + 1].songname!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.ebGaramond(
                                              textStyle: TextStyle(
                                                  letterSpacing: .5,
                                                  fontSize: width / 25,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      PlayerBuilder.realtimePlayingInfos(
                                        player: player,
                                        builder:
                                            (context, realtimePlayingInfos) {
                                          duration = realtimePlayingInfos
                                              .current!.audio.duration;
                                          position = realtimePlayingInfos
                                              .currentPosition;

                                          return ProgressBar(
                                            baseBarColor: Colors.black38,
                                            progressBarColor:
                                                const Color.fromARGB(
                                                    206, 223, 64, 251),
                                            thumbColor: Colors.deepPurpleAccent,
                                            thumbRadius: 5,
                                            timeLabelPadding: 5,
                                            progress: position,
                                            timeLabelTextStyle: const TextStyle(
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            total: duration,
                                            onSeek: (duration) async {
                                              await player.seek(duration);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) {
                                      return Container(
                                        width: double.infinity,
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  player.seekBy(
                                                    const Duration(
                                                        seconds: -10),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.replay_10_rounded,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  size: 40,
                                                )),
                                            IconButton(
                                              onPressed: () {
                                                previous(
                                                    player, value, allDbdongs);
                                              },
                                              icon: const Icon(
                                                Icons.skip_previous_outlined,
                                                color: Colors.deepPurpleAccent,
                                                size: 44,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   isAnimated = !isAnimated;
                                                    //   if (isAnimated) {
                                                    //     iconcontroller
                                                    //         .forward();
                                                    //     player
                                                    //         .playlistPlayAtIndex(
                                                    //             0);
                                                    //   } else {
                                                    //     iconcontroller
                                                    //         .reverse();
                                                    //     player.pause();
                                                    //   }
                                                    // });
                                                    setState(() {
                                                      isAnimated = !isAnimated;
                                                      if (isAnimated) {
                                                        iconcontroller
                                                            .forward();
                                                        playbutton(player,
                                                            value, allDbdongs);
                                                      } else {
                                                        iconcontroller
                                                            .reverse();
                                                        player.stop();
                                                      }
                                                    });
                                                  },
                                                  child: AnimatedIcon(
                                                      icon: AnimatedIcons
                                                          .play_pause,
                                                      size: 44,
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      progress: iconcontroller),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  next(player, value,
                                                      allDbdongs);
                                                  // await player.next();
                                                  // setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.skip_next_outlined,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  size: 44,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  player.seekBy(
                                                    const Duration(seconds: 10),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.forward_10_sharp,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  size: 40,
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/arrowdown.png'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    iconcontroller.dispose();
    super.dispose();
  }

  void playbutton(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    player.open(
      Audio.file(dbsongs[index].songurl!),
      showNotification: true,
    );
    setState(() {
      current.currentvalue.value;
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
      current.currentvalue.value--;
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
      current.currentvalue.value++;
    });
    await player.stop();
  }

  // void tensec(AssetsAudioPlayer assetsAudioPlayer, int index,
  //     List<Songs> dbsongs) async{

  // }
}
