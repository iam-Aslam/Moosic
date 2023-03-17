// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/presentations/pages/library/most_played/most_played.dart';
import '../models/favouriteModel.dart';

late Box<favourites> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<favourites>(favourbox);
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox("Mostplayed");
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
    RecentlyPlayedBox.add(value);
  }
}

addMostplayed(int index, MostPlayed value) {
  final box = MostplayedBox.getInstance();
  List<MostPlayed> list = box.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    box.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    box.deleteAt(index);
    box.put(index, value);
  }
  int count = value.count;
  value.count = count + 1;
}
