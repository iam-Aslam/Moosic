import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/presentations/widgets/common.dart';

class Recentlyplayed extends StatefulWidget {
  const Recentlyplayed({super.key});

  @override
  State<Recentlyplayed> createState() => _RecentlyplayedState();
}

final player = AssetsAudioPlayer.withId('0');

class _RecentlyplayedState extends State<Recentlyplayed> {
  // ignore: prefer_typing_uninitialized_variables
  var orientation, size, height, width;
  final List<RecentlyPlayedModel> recentsongs = [];
  final box = RecentlyPlayedBox.getInstance();
  late List<RecentlyPlayedModel> recent = box.values.toList();
  List<Audio> recsongs = [];
  @override
  void initState() {
    final List<RecentlyPlayedModel> recentsong =
        box.values.toList().reversed.toList();
    for (var i in recentsong) {
      recsongs.add(Audio.file(i.songurl.toString(),
          metas: Metas(
            artist: i.artist,
            title: i.songname,
            id: i.id.toString(),
          )));
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
        body: Stack(children: [
          Column(
            children: [
              SizedBox(
                width: width / 1,
                height: height / 16,
                // child: FittedBox(
                //   fit: BoxFit.fill,
                //   child: Image.asset(
                //     'assets/images/recent.jpg',
                //   ),
                // ),
              ),
              ValueListenableBuilder<Box<RecentlyPlayedModel>>(
                valueListenable: box.listenable(),
                builder: (context, Box<RecentlyPlayedModel> dbrecent, child) {
                  List<RecentlyPlayedModel> recentsongs =
                      dbrecent.values.toList().reversed.toList();
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.5),
                      child: Column(
                        children: [
                          titleslib(title: 'Recently Played'),
                          Expanded(
                            child: GridView.count(
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              children: List.generate(
                                recentsongs.length,
                                (index) => favoritedummy(
                                    song: recentsongs[index].songname!,
                                    image: recentsongs[index].id!,
                                    time: recentsongs[index].duration!),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
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
