part of 'allsongs_bloc.dart';

@immutable
abstract class AllsongsState {}

class AllsongsInitial extends AllsongsState {
  AllsongsInitial();
}

class DisplayAllSongs extends AllsongsState {
  final List<Songs> Allsongs;

  DisplayAllSongs(this.Allsongs);
}
