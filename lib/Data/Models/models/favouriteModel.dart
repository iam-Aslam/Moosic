// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types

import 'package:hive_flutter/hive_flutter.dart';
part 'favouriteModel.g.dart';

@HiveType(typeId: 1)
class favouritesmodel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  String? artist;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  String? songurl;
  favouritesmodel({
    required this.id,
    required this.songname,
    required this.artist,
    required this.duration,
    required this.songurl,
  });
}

String favourbox = 'Favourites';

class FavouriteBox {
  static Box<favouritesmodel>? _box;
  static Box<favouritesmodel> getInstance() {
    return _box ??= Hive.box(favourbox);
  }
}
