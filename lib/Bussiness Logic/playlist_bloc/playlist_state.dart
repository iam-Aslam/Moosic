part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistState extends Equatable {}

class PlaylistInitial extends PlaylistState {
  @override
  List<Object?> get props => [];
}

class DisplayPlaylist extends PlaylistState {
  final List<PlaylistSongs> Playlist;

  DisplayPlaylist(this.Playlist);

  @override
  List<Object> get props => [Playlist];
}
