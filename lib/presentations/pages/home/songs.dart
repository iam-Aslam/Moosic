import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/common.dart';
import '../current_playing/current.dart';

class songs extends StatefulWidget {
  const songs({super.key});

  @override
  State<songs> createState() => _songsState();
}

final mostbox = MostplayedBox.getInstance();

final OnAudioQuery audioQuery = OnAudioQuery();
final AssetsAudioPlayer player = AssetsAudioPlayer();
final List<MostPlayed> mostplayed = mostbox.values.toList();

class _songsState extends State<songs> {
  final box = SongBox.getInstance();
  List<Audio> Converted_songs = [];
  bool isadded = true;
  @override
  void initState() {
    List<Songs> song_database = box.values.toList();

    for (var i in song_database) {
      Converted_songs.add(
        Audio.file(
          i.songurl!,
          metas: Metas(
            title: i.songname,
            id: i.id.toString(),
          ),
        ),
      );
    }
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
        body: Container(
          width: double.infinity,
          height: height / 1.24,
          //  color: Colors.amberAccent,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black26),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 20, top: 10),
                        child: ValueListenableBuilder<Box<Songs>>(
                          valueListenable: box.listenable(),
                          builder: ((context, Box<Songs> allsongbox, child) {
                            List<Songs> songlist_db =
                                allsongbox.values.toList();
                            //log(songlist_db.toString());
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0, color: Colors.black26),
                                ),
                              ),
                              width: 400,
                              height: height / 1.39,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      titlesingle(title: 'All Songs'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: ((context, index) {
                                              RecentlyPlayedModel? recentsong;
                                              //  Songs currentsongindex =
                                              //      songlist_db[index];
                                              // MostPlayed mostplayedsong =
                                              //     mostplayed[index];
                                              return listtile(
                                                mostsong: mostplayed,
                                                songs: songlist_db[index],
                                                recent: recentsong,
                                                isadded: isadded,
                                                context: context,
                                                index: index,
                                                image: songlist_db[index].id!,
                                                song: songlist_db[index]
                                                    .songname!,
                                                artist:
                                                    songlist_db[index].artist ??
                                                        "No Artist",
                                              );
                                            }),
                                            separatorBuilder:
                                                ((context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    )),
                                            itemCount: songlist_db.length),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
