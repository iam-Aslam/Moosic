// ignore_for_file: non_constant_identifier_names
import 'dart:developer';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import '../../../Data/Models/functions/dbfunctions.dart';

addfavour(int index) async {
  log('okay$index');

  final box = SongBox.getInstance();
  List<Songs> allsongs = await box.values.toList();
  print(allsongs[index]);
  List<favourites> likedsongs = [];
  likedsongs = favouritedb.values.toList();
  likedsongs.add(
    favourites(
        id: allsongs[index].id,
        songname: allsongs[index].songname,
        artist: allsongs[index].artist,
        duration: allsongs[index].duration,
        songurl: allsongs[index].songurl),
  );
  log(likedsongs[index].songname!);
}
