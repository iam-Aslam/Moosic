// ignore_for_file: must_be_immutable
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moosic/Bussiness%20Logic/favourites_bloc/favourites_bloc.dart';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/presentations/pages/current_playing/current.dart';
import 'package:moosic/presentations/widgets/common.dart';

class FavoritesWidget extends StatelessWidget {
  FavoritesWidget({super.key});

  final List<favouritesmodel> likedsongs = [];

  final favourbox = FavouriteBox.getInstance();
  final player = AssetsAudioPlayer.withId('0');
  late List<favouritesmodel> liked = favourbox.values.toList();

  List<Audio> favsong = [];

  @override
  Widget build(BuildContext context) {
    final List<favouritesmodel> likedsong =
        favourbox.values.toList().reversed.toList();
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
          padding: const EdgeInsets.only(left: 4.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(context),
              titlesfav(title: 'Favorites'),
              BlocBuilder<FavouritesBloc, FavouritesState>(
                builder: (context, state) {
                  if (state is FavouritesInitial) {
                    context.read<FavouritesBloc>().add(GetFavSongs());
                  }
                  if (state is DisplayFavSongs) {
                    return state.favorites.isNotEmpty
                        ? Expanded(
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              children: List.generate(
                                state.favorites.length,
                                (index) => favorite(
                                  favour: favsong,
                                  audioPlayer: player,
                                  index: index,
                                  song: state.favorites[index].songname!,
                                  image: state.favorites[index].id!,
                                  time: state.favorites[index].duration!,
                                  context: context,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: const Text(
                              "You haven't liked any songs!",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
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
