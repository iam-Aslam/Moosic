import 'package:hive_flutter/hive_flutter.dart';
part 'recentlymodel.g.dart';

@HiveType(typeId: 2)
class RecentlyPlayedModel {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  @HiveField(5)
  int? index;
  RecentlyPlayedModel(
      {this.songname,
      this.artist,
      this.duration,
      this.songurl,
      required this.id,
      required this.index});
}

String recentbox = 'RecentlyPlayed';

class RecentlyPlayedBox {
  static Box<RecentlyPlayedModel>? _box;
  static Box<RecentlyPlayedModel> getInstance() {
    return _box ??= Hive.box(recentbox);
  }
}
