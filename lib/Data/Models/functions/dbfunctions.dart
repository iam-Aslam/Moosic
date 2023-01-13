// ignore_for_file: non_constant_identifier_names

import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/presentations/pages/library/recent_played/recent_played.dart';
import '../models/favouriteModel.dart';

late Box<favourites> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<favourites>(favourbox);
}

late Box<Recentlyplayed> RecentlyPlayedBox;
openrecentlyplayeddb() async {
  RecentlyPlayedBox = await Hive.openBox("recentlyplayed");
}
