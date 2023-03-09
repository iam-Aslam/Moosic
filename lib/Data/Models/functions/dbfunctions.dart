// ignore_for_file: non_constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import '../models/favouriteModel.dart';

late Box<favourites> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<favourites>(favourbox);
}

late Box<RecentlyPlayedModel> RecentlyPlayedBox;
openrecentlyplayeddb() async {
  RecentlyPlayedBox = await Hive.openBox("recentlyplayed");
}

addRecently(RecentlyPlayedModel value) {
  List<RecentlyPlayedModel> list = RecentlyPlayedBox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    RecentlyPlayedBox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    RecentlyPlayedBox.deleteAt(index);
    RecentlyPlayedBox.delete(value);
  }
}
