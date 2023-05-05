part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedEvent {}

class GetMostPlayed extends MostplayedEvent {
  GetMostPlayed();
}

class UpdateCount extends MostplayedEvent {
  final mostplay;
  final int index;
  UpdateCount({required this.mostplay, required this.index});
  List<Object> get props => [mostplay, index];
}
