part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedState extends Equatable {}

class MostplayedInitial extends MostplayedState {
  @override
  List<Object> get props => [];
}

class DisplayMostPlayed extends MostplayedState {
  final List<MostPlayed> mostPlayed;

  DisplayMostPlayed({
    required this.mostPlayed,
  });
  @override
  List<Object> get props => [mostPlayed];
}
