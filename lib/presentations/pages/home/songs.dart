import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moosic/Bussiness%20Logic/allsongs_bloc/allsongs_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AllsongsBloc>(context).add(GetAllSongs());
    });
    orientation = MediaQuery.of(context).orientation;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: height / 1.26,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                  child: BlocBuilder<AllsongsBloc, AllsongsState>(
                      //  valueListenable: box.listenable(),
                      builder: (context, state) {
                    //  List<Songs> songlist_db = allsongbox.values.toList();
                    //log(songlist_db.toString());
                    if (state is AllsongsInitial) {
                      context.read<AllsongsBloc>().add(GetAllSongs());
                    }
                    if (state is DisplayAllSongs) {
                      return state.Allsongs.isNotEmpty
                          ? Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0, color: Colors.black26),
                                ),
                              ),
                              width: width / 1,
                              height: height / 1.42,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            return listtile(
                                              mostsong: mostplayed,
                                              songs: state.Allsongs[index],
                                              recent: recentsong,
                                              isadded: isadded,
                                              context: context,
                                              index: index,
                                              image: state.Allsongs[index].id!,
                                              song: state
                                                  .Allsongs[index].songname!,
                                              artist: state
                                                      .Allsongs[index].artist ??
                                                  "No Artist",
                                            );
                                          }),
                                          separatorBuilder: ((context, index) =>
                                              const SizedBox(
                                                height: 5,
                                              )),
                                          itemCount: state.Allsongs.length),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
