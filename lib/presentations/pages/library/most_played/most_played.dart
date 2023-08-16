import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moosic/Bussiness%20Logic/mostplayed_bloc/mostplayed_bloc.dart';
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

  List<MostPlayed> mostplayedsongs = [];
  @override
  Widget build(BuildContext context) {
    //Contents in init state....
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
    //<-------------------------------------------->
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
                      BlocBuilder<MostplayedBloc, MostplayedState>(
                        builder: (context, state) {
                          if (state is MostplayedInitial) {
                            context.read<MostplayedBloc>().add(GetMostPlayed());
                          }
                          if (state is DisplayMostPlayed) {
                            return state.mostPlayed.isNotEmpty
                                ? Expanded(
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      children: List.generate(
                                        state.mostPlayed.length,
                                        (index) => favoritedummy(
                                            audioplayer: audioPlayer,
                                            recentsongs: songs,
                                            index: index,
                                            context: context,
                                            song: state
                                                .mostPlayed[index].songname,
                                            image: state.mostPlayed[index].id,
                                            time: state
                                                .mostPlayed[index].duration),
                                      ),
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Your most played songs will appear here!",
                                          style: GoogleFonts.kanit(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
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
