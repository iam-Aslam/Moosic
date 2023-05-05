import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../Data/Models/models/recentlymodel.dart';

part 'recentlyplayed_event.dart';
part 'recentlyplayed_state.dart';

class RecentlyplayedBloc
    extends Bloc<RecentlyplayedEvent, RecentlyplayedState> {
  RecentlyplayedBloc() : super(RecentlyplayedInitial()) {
    on<GetRecentlyPlayed>((event, emit) {
      try {
        final box = RecentlyPlayedBox.getInstance();
        final List<RecentlyPlayedModel> recentList = box.values.toList();
        emit(DisplayRecently(recentPlay: recentList));
      } catch (e) {
        log(e.toString());
      }
    });
    on<AddToRecentlyPlayed>((event, emit) {
      final box = RecentlyPlayedBox.getInstance();
      final List<RecentlyPlayedModel> recentList = box.values.toList();
      try {
        bool isAlready = recentList
            .where((element) =>
                element.songname == event.recentlyPlayedModel.songname)
            .isEmpty;
        if (isAlready) {
          box.add(event.recentlyPlayedModel);
          add(GetRecentlyPlayed());
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
