// ignore_for_file: non_constant_identifier_names
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import '../models/favouriteModel.dart';

late Box<favouritesmodel> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<favouritesmodel>(favourbox);
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
  bool isNot =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isNot == true) {
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
  bool isNot =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isNot == true) {
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

addMostplayednew(MostPlayed value) {
  final box = MostplayedBox.getInstance();
  List<MostPlayed> list = box.values.toList();
  bool isNot = list.where((element) => element.id == value.id).isEmpty;

  int count = value.count;
  value.count = count + 1;
  log('${value.count}');
}
