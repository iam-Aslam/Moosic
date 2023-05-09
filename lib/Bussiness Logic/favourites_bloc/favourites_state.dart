part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState extends Equatable {}

class FavouritesInitial extends FavouritesState {
  FavouritesInitial();
  @override
  List<Object?> get props => [];
}

class DisplayFavSongs extends FavouritesState {
  final List<favouritesmodel> favorites;

  DisplayFavSongs(this.favorites);
  @override
  List<Object> get props => [favorites];
}
