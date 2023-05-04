part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent extends Equatable {}

class GetFavSongs extends FavouritesEvent {
  GetFavSongs();

  @override
  List<Object?> get props => [];
}

class AddorRemoveFavourites extends FavouritesEvent {
  final favourites favsong;
  final int index;

  AddorRemoveFavourites(this.favsong, this.index);
  @override
  List<Object> get props => [favsong, index];
}

class RemoveFromFavourites extends FavouritesEvent {
  final favourites favsong;
  final int index;

  RemoveFromFavourites(this.favsong, this.index);
  @override
  List<Object> get props => [favsong, index];
}

class RemoveFromFavouritesList extends FavouritesEvent {
  final int index;

  RemoveFromFavouritesList(this.index);
  @override
  List<Object> get props => [index];
}
