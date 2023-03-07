// ignore_for_file: non_constant_identifier_names
import 'dart:developer';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import '../../../Data/Models/functions/dbfunctions.dart';

addfavour(int index) async {
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<favourites> likedsongs = [];
  likedsongs = favouritedb.values.toList();

  bool isalready = likedsongs
      .where((element) => element.songname == allsongs[index].songname)
      .isEmpty;
  if (isalready) {
    favouritedb.add(
      favourites(
          id: allsongs[index].id,
          songname: allsongs[index].songname,
          artist: allsongs[index].artist,
          duration: allsongs[index].duration,
          songurl: allsongs[index].songurl),
    );
  } else {
    likedsongs
        .where((element) => element.songname == allsongs[index].songname)
        .isEmpty;
    int currentidx =
        likedsongs.indexWhere((element) => element.id == allsongs[index].id);
    await favouritedb.deleteAt(currentidx);
    await favouritedb.deleteAt(index);
  }
  log(likedsongs[index].songname!);
}

removefavour(int index) async {
  final box = SongBox.getInstance();
  final box2 = FavouriteBox.getInstance();
  List<favourites> favourite = box2.values.toList();
  List<Songs> songs = box.values.toList();
  int currentidx =
      favourite.indexWhere((element) => element.id == songs[index].id);
  await favouritedb.deleteAt(currentidx);
}

bool checkFavour(int index, BuildContext) {
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<favourites> favouritesongs = [];
  favourites value = favourites(
      id: allsongs[index].id,
      songname: allsongs[index].songname,
      artist: allsongs[index].artist,
      duration: allsongs[index].duration,
      songurl: allsongs[index].songurl);
  favouritesongs = favouritedb.values.toList();
  bool isAlready = favouritesongs
      .where((element) => element.songname == value.songname)
      .isEmpty;
  return isAlready ? true : false;
}
