// ignore_for_file: avoid_print
import 'package:moosic/Data/Models/models/playlistmodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';

//To add new playlist
newplaylist(String title) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  bool isAlready =
      dbplaylist.where((element) => element.playlistname == title).isEmpty;
  if (isAlready) {
    List<Songs> playlistsongs = [];
    playlistbox.add(
      PlaylistSongs(playlistname: title, playlistssongs: playlistsongs),
    );
  }
}

//To add songs to playlists
addtoplaylist(Songs song, int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  print(dbplaylist);
}

//To delete playlist
deleteplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.deleteAt(index);
}

//To delete songs from playlist
deltefromplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.delete(index);
}
