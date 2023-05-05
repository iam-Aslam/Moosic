part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class GetPlayListSongs extends PlaylistEvent {
  GetPlayListSongs();
}

class AddtoPlaylist extends PlaylistEvent {
  final int index;
  AddtoPlaylist(this.index);
}

class CreatePlaylist extends PlaylistEvent {
  final String title;
  CreatePlaylist(this.title);
}

class DeletePlaylistSong extends PlaylistEvent {
  final int index;
  DeletePlaylistSong(this.index);
  List<Object> get props => [index];
}

class DeletePlaylist extends PlaylistEvent {
  final int index;

  DeletePlaylist(this.index);
}
