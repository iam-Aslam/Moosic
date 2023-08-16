import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import '../../../Data/Models/functions/dbfunctions.dart';

bool checkFavour(int index, BuildContext) {
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<favouritesmodel> favouritesongs = [];
  favouritesmodel value = favouritesmodel(
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
