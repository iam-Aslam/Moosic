// ignore_for_file: camel_case_types
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/presentations/pages/current_playing/current.dart';
import 'package:moosic/presentations/widgets/common.dart';

class favorites extends StatefulWidget {
  const favorites({super.key});

  @override
  State<favorites> createState() => _favoritesState();
}

final player = AssetsAudioPlayer.withId('0');

class _favoritesState extends State<favorites> {
  final List<favourites> likedsongs = [];
  final box = FavouriteBox.getInstance();
  late List<favourites> liked = box.values.toList();
  // bool isadded = true;
  List<Audio> favsong = [];
  @override
  void initState() {
    final List<favourites> likedsong = box.values.toList().reversed.toList();
    for (var i in likedsong) {
      favsong.add(
        Audio.file(
          i.songurl.toString(),
          metas: Metas(
            artist: i.artist,
            title: i.songname,
            id: i.id.toString(),
          ),
        ),
      );
    }
    setState(() {});
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
        height: height / 1.26,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black26),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(context),
              titlesfav(title: 'Favorites'),
              ValueListenableBuilder<Box<favourites>>(
                valueListenable: box.listenable(),
                builder: (context, Box<favourites> dbfavour, child) {
                  List<favourites> likedsongs =
                      dbfavour.values.toList().reversed.toList();
                  log(likedsongs.toString());
                  //log(likedsongs[0].songname!);

                  return Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        likedsongs.length,
                        (index) => favorite(
                            index: index,
                            song: likedsongs[index].songname!,
                            image: likedsongs[index].id!,
                            time: likedsongs[index].duration!),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
