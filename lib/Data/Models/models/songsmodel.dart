// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'songsmodel.g.dart';

@HiveType(typeId: 0)
class Songs {
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

  Songs({
    required this.id,
    required this.songname,
    required this.artist,
    required this.duration,
    required this.songurl,
  });
}

String boxname = 'AllSongs';

class SongBox {
  static Box<Songs>? _box;
  static Box<Songs> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
