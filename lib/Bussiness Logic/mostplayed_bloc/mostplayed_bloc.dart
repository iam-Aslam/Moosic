import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial()) {
    on<GetMostPlayed>((event, emit) {
      final box = MostplayedBox.getInstance();
      final List<MostPlayed> mostList = box.values.toList();
      emit(DisplayMostPlayed(mostPlayed: mostList));
    });
    on<UpdateCount>((event, emit) {
      try {
        final box = MostplayedBox.getInstance();
        List<MostPlayed> mostList = box.values.toList();
        int count = event.mostplay.count;
        event.mostplay.count = count + 1;
        log('most play count==================================${event.mostplay.count}');
        if (event.mostplay.count > 5) {
          bool isAlready = mostList
              .where((element) => element.songname == event.mostplay.songname)
              .isEmpty;
          if (isAlready == true) {
            box.add(event.mostplay);
            log('${event.mostplay.songname}adde to most played');
            add(GetMostPlayed());
          } else {
            int index = mostList.indexWhere(
                (element) => element.songname == event.mostplay.songname);
            box.deleteAt(index);
            // mostplayedsongs.add(event.mostplay);
            box.put(index, event.mostplay);
            add(GetMostPlayed());
          }
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
