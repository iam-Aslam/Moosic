import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Models/models/songsmodel.dart';

part 'allsongs_event.dart';
part 'allsongs_state.dart';

class AllsongsBloc extends Bloc<AllsongsEvent, AllsongsState> {
  AllsongsBloc() : super(AllsongsInitial()) {
    on<GetAllSongs>((event, emit) {
      try {
        final databaseSongs = SongBox.getInstance();
        List<Songs> allDbsongs = databaseSongs.values.toList();
        emit(DisplayAllSongs(allDbsongs));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
