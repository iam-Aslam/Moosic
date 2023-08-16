// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moosic/Bussiness%20Logic/recentyplayed_bloc/recentlyplayed_bloc.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/presentations/widgets/common.dart';

class Recentlyplayed extends StatelessWidget {
  Recentlyplayed({super.key});
  var orientation, size, height, width;

  final List<RecentlyPlayedModel> recentsongs = [];

  final box = RecentlyPlayedBox.getInstance();

  late List<RecentlyPlayedModel> recent = box.values.toList();

  List<Audio> recsongs = [];

  @override
  Widget build(BuildContext context) {
    // function that was in init state
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
    //bloc widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<RecentlyplayedBloc>(context).add(GetRecentlyPlayed());
    });
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
                height: height / 15.5,
              ),
              BlocBuilder<RecentlyplayedBloc, RecentlyplayedState>(
                builder: (context, state) {
                  if (state is RecentlyplayedInitial) {
                    context.read<RecentlyplayedBloc>().add(GetRecentlyPlayed());
                  }
                  if (state is DisplayRecently) {
                    return state.recentPlay.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.5),
                              child: Column(
                                children: [
                                  titleslib(title: 'Recently Played'),
                                  Expanded(
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      children: List.generate(
                                        state.recentPlay.length,
                                        (index) => favoritedummy(
                                            index: index,
                                            context: context,
                                            recentsongs: recsongs,
                                            audioplayer: player,
                                            song: state
                                                .recentPlay[index].songname!,
                                            image: state.recentPlay[index].id!,
                                            time: state
                                                .recentPlay[index].duration!),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Your Recently played songs",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
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

final player = AssetsAudioPlayer.withId('0');
