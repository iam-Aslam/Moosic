import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final TextEditingController searchcontroller = TextEditingController();

// final _searchController = TextEditingController();
// List<Songs> songList = Hive.box<Songs>(boxname).values.toList();
// List<Songs> songDisplay = List<Songs>.from(songList);

class _SearchScreenState extends State<SearchScreen> {
  late List<Songs> dbsongs = [];
  List<Audio> allsongs = [];

  late List<Songs> searchlist = List.from(dbsongs);
  bool istaped = true;

  final box = SongBox.getInstance();
  @override
  void initState() {
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // searchTextField(
            //   context: context,
            // ),
            TextFormField(
              autofocus: true,
              controller: searchcontroller,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(234, 236, 238, 2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
                hintText: 'search',
              ),
              onChanged: (value) {
                // _searchStudent(value);
                updateSearch(value);
              },
            ),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchlist.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                      child: ListTile(
                        onTap: () {
                          // NowPlayingSlider.enteredvalue.value = index;
                          player.open(
                            Audio.file(searchlist[index].songurl!,
                                metas: Metas(
                                    title: searchlist[index].songname,
                                    artist: searchlist[index].artist,
                                    id: searchlist[index].id.toString())),
                            showNotification: true,
                          );
                        },
                        leading: QueryArtworkWidget(
                          keepOldArtwork: true,
                          artworkBorder: BorderRadius.circular(10),
                          id: searchlist[index].id!,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(searchlist[index].songname!,
                            style: const TextStyle(color: Colors.black)),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }

  updateSearch(String value) {
    setState(() {
      searchlist = dbsongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();

      allsongs.clear();
      for (var item in searchlist) {
        allsongs.add(Audio.file(item.songurl.toString(),
            metas: Metas(title: item.songname, id: item.id.toString())));
      }
    });
  }
}

Widget searchTextField({required BuildContext context}) {
  return TextFormField(
    autofocus: true,
    controller: searchcontroller,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => Navigator.of(context).pop(),
      ),
      filled: true,
      fillColor: const Color.fromRGBO(234, 236, 238, 2),
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
      hintText: 'search',
    ),
    onChanged: (value) {
      // _searchStudent(value);
      //updateSearch(value);
    },
  );
}
