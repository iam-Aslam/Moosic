import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/functions/addplaylist.dart';
import 'package:moosic/presentations/pages/playlist/single_playlist/current_playlist.dart';
import 'package:moosic/presentations/widgets/common.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../Data/Models/models/playlistmodel.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final playlistbox = PlaylistSongsbox.getInstance();
  late List<PlaylistSongs> playlistsongs = playlistbox.values.toList();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
          // ignore: sort_child_properties_last
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
              Expanded(
                  child: ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                  List<PlaylistSongs> playlistsong =
                      playlistsongs.values.toList();

                  return playlistsong.isNotEmpty
                      ? GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            playlistsong.length,
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
                                                      playlistname:
                                                          playlistsong[index]
                                                              .playlistname,
                                                    ))));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: playlistsong[index]
                                                .playlistssongs!
                                                .isNotEmpty
                                            ? QueryArtworkWidget(
                                                id: playlistsong[index]
                                                    .playlistssongs![0]
                                                    .id!,
                                                type: ArtworkType.AUDIO,
                                                keepOldArtwork: true,
                                                artworkHeight: 130,
                                                artworkWidth: 130,
                                                artworkBorder:
                                                    BorderRadius.circular(8),
                                              )
                                            : Image.asset(
                                                'assets/images/default.png',
                                                height: 130,
                                                width: 130,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            playlistsong[index].playlistname!,
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  fontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        PopupMenuButton<int>(
                                          itemBuilder: (context) => [
                                            // PopupMenuItem 1
                                            PopupMenuItem(
                                              onTap: () {
                                                deleteplaylist(index);
                                              },
                                              value: 1,
                                              // row with 2 children
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
                        )
                      : const Center(
                          child: Text('Playlist is empty'),
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
