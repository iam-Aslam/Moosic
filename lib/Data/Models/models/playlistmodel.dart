import 'package:hive_flutter/hive_flutter.dart';
import 'songsmodel.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 3)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistssongs;
  PlaylistSongs({required this.playlistname, required this.playlistssongs});
}

class PlaylistSongsbox {
  static Box<PlaylistSongs>? _box;
  static Box<PlaylistSongs> getInstance() {
    return _box ??= Hive.box('playlist');
  }
}
