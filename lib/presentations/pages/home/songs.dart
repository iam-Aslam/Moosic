// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/common.dart';
import '../../widgets/data.dart';

class songs extends StatefulWidget {
  const songs({super.key});

  @override
  State<songs> createState() => _songsState();
}

final OnAudioQuery audioQuery = OnAudioQuery();
final AssetsAudioPlayer player = AssetsAudioPlayer();

class _songsState extends State<songs> {
  final box = SongBox.getInstance();
  List<Audio> convertaudio = [];

  @override
  void initState() {
    List<Songs> dbsongs = box.values.toList();

    for (var item in dbsongs) {
      convertaudio.add(Audio.file(item.songurl!,
          metas: Metas(title: item.songname, id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    List<Songs> songdata = box.values.toList();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: 690,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        titles(title: 'Playlists', context: context),
                        Container(
                          height: 130,
                          child: Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 15),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => playlist(
                                    context: context,
                                    name: PlaylistNames[index],
                                    image: PlaylistImages[index]),
                                itemCount: PlaylistNames.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 20, top: 10),
                          child: ValueListenableBuilder<Box<Songs>>(
                            valueListenable: box.listenable(),
                            builder: ((context, Box<Songs> allsongbox, child) {
                              List<Songs> allDbsongs =
                                  allsongbox.values.toList();
                              if (allsongbox == null) {
                                return const Center(
                                  child: Text('Empty'),
                                );
                              }
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.black26),
                                  ),
                                ),
                                width: 400,
                                height: 466,
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titlesingle(title: 'Songs'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                itemBuilder: ((context, index) {
                                                  Songs songs =
                                                      allDbsongs[index];
                                                  return listtile(
                                                    image: SongImages[0],
                                                    song: allDbsongs[index]
                                                        .songname!,
                                                    artist: allDbsongs[index]
                                                            .artist ??
                                                        "No Artist",
                                                    duration: Songtime[0],
                                                  );
                                                }),
                                                separatorBuilder:
                                                    ((context, index) =>
                                                        SizedBox(
                                                          height: 10,
                                                        )),
                                                itemCount: allDbsongs.length))
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
