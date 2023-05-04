import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:moosic/presentations/pages/home/home.dart';

import '../../Data/Models/models/favouriteModel.dart';
import '../../Data/Models/models/songsmodel.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<GetFavSongs>((event, emit) {
      try {
        final favouritebox = FavouriteBox.getInstance();
        List<favourites> favouritesongs = favouritebox.values.toList();
        emit(DisplayFavSongs(favouritesongs));
      } catch (e) {
        log(e.toString());
      }
    });
    on<AddorRemoveFavourites>((event, emit) {
      try {
        List<Songs> allSongs = box.values.toList();
        final favouriteBox = FavouriteBox.getInstance();
        final favouriteSongs = favouriteBox.values.toList();
        bool isAlready = favouriteSongs
            .where(
                (element) => element.songname == allSongs[event.index].songname)
            .isEmpty;
        if (isAlready) {
          favouriteBox.add(event.favsong);
          add(GetFavSongs());
        } else {
          int index = favouriteSongs.indexWhere(
              (element) => element.songname == event.favsong.songname);
          favouriteBox.deleteAt(index);
          print('deleted at $index');
          print(favouriteBox.length);
          // favbox.deleteAt(event.index);

          add(GetFavSongs());
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<RemoveFromFavouritesList>((event, emit) {
      try {
        final favbox = FavouriteBox.getInstance();
        favbox.deleteAt(event.index);

        add(GetFavSongs());
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  }
}
