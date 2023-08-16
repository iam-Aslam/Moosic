// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moosic/Bussiness%20Logic/playlist_bloc/playlist_bloc.dart';
import 'package:moosic/presentations/pages/playlist/single_playlist/current_playlist.dart';
import 'package:moosic/presentations/widgets/common.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../Data/Models/models/playlistmodel.dart';

class Playlist extends StatelessWidget {
  Playlist({super.key});

  final playlistbox = PlaylistSongsbox.getInstance();

  late List<PlaylistSongs> playlistsongs = playlistbox.values.toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            showPlaylistOptionsadd(context);
          }),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerpages(context),
              titlesfav(title: 'Playlists'),
              Expanded(child: BlocBuilder<PlaylistBloc, PlaylistState>(
                builder: (context, state) {
                  if (state is PlaylistInitial) {
                    context.read<PlaylistBloc>().add(GetPlayListSongs());
                  }
                  if (state is DisplayPlaylist) {
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        state.Playlist.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                          ),
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CurrentPlaylist(
                                                  index: index,
                                                  playlistname: state
                                                      .Playlist[index]
                                                      .playlistname,
                                                ))));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: state.Playlist[index].playlistssongs!
                                            .isNotEmpty
                                        ? QueryArtworkWidget(
                                            id: state.Playlist[index]
                                                .playlistssongs![0].id!,
                                            type: ArtworkType.AUDIO,
                                            keepOldArtwork: true,
                                            artworkHeight: 130,
                                            artworkWidth: 130,
                                            artworkBorder:
                                                BorderRadius.circular(8),
                                            nullArtworkWidget: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                'assets/images/empty.jpg',
                                                height: 124,
                                                width: 124,
                                              ),
                                            ),
                                          )
                                        : Image.asset(
                                            'assets/images/default.png',
                                            height: 124,
                                            width: 124,
                                          ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        state.Playlist[index].playlistname!,
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton<int>(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            context
                                                .read<PlaylistBloc>()
                                                .add(DeletePlaylist(index));
                                          },
                                          value: 1,
                                          child: Row(
                                            children: const [
                                              Icon(Icons.delete),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Delete")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
