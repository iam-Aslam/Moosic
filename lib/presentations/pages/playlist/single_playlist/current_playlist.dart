// ignore_for_file: must_be_immutable
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/playlistmodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/widgets/common.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CurrentPlaylist extends StatefulWidget {
  CurrentPlaylist({super.key, required this.index, required this.playlistname});
  int? index;
  String? playlistname;
  @override
  State<CurrentPlaylist> createState() => _CurrentPlaylistState();
}

class _CurrentPlaylistState extends State<CurrentPlaylist> {
  var orientation, size, height, width;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> converted = [];
  @override
  void initState() {
    final playlistbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();
    for (var i in playlistsong[widget.index!].playlistssongs!) {
      converted.add(
        Audio.file(
          i.songurl!,
          metas: Metas(
            title: i.songname,
            artist: i.artist,
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

    final playlistbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: [
              SizedBox(
                width: width / 1,
                height: height / 2.5,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/images/playlist.jpg',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.5),
                  child: Column(
                    children: [
                      titleslib(
                          title: playlistsong[widget.index!].playlistname!),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: playlistbox.listenable(),
                          builder: (context, Box<PlaylistSongs> playlistsongs,
                              child) {
                            List<PlaylistSongs> playlistsong =
                                playlistsongs.values.toList();
                            List<Songs>? playsong =
                                playlistsong[widget.index!].playlistssongs;

                            return playsong!.isNotEmpty
                                ? GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    children: List.generate(
                                        playsong.length,
                                        (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                              ),
                                              child: player.builderCurrent(
                                                builder: (context, playing) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          player.open(
                                                            Playlist(
                                                                audios:
                                                                    converted,
                                                                startIndex:
                                                                    index),
                                                            headPhoneStrategy:
                                                                HeadPhoneStrategy
                                                                    .pauseOnUnplugPlayOnPlug,
                                                            showNotification:
                                                                true,
                                                          );
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  'current');
                                                        },
                                                        child:
                                                            QueryArtworkWidget(
                                                          id: int.parse(playing
                                                              .audio
                                                              .audio
                                                              .metas
                                                              .id!),
                                                          type:
                                                              ArtworkType.AUDIO,
                                                          nullArtworkWidget:
                                                              ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child: Image.asset(
                                                              'assets/images/empty.jpg',
                                                              height: 123,
                                                              width: 123,
                                                            ),
                                                          ),
                                                          keepOldArtwork: true,
                                                          artworkHeight: 123,
                                                          artworkWidth: 123,
                                                          artworkBorder:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                              player
                                                                  .getCurrentAudioTitle,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: const TextStyle(
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          PopupMenuButton<int>(
                                                            itemBuilder:
                                                                (context) => [
                                                              PopupMenuItem(
                                                                onTap: () {
                                                                  playsong
                                                                      .removeAt(
                                                                          index);
                                                                  playlistbox.putAt(
                                                                      widget
                                                                          .index!,
                                                                      PlaylistSongs(
                                                                          playlistname: widget
                                                                              .playlistname,
                                                                          playlistssongs:
                                                                              playsong));
                                                                },
                                                                value: 1,
                                                                child: Row(
                                                                  children: const [
                                                                    Icon(Icons
                                                                        .delete),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                        "Remove")
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            )))
                                : const Center(
                                    child: Text('NO SONGS'),
                                  );
                          },
                        ),
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
