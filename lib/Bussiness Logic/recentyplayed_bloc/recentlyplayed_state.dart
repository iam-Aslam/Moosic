// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recentlyplayed_bloc.dart';

@immutable
abstract class RecentlyplayedState extends Equatable {}

class RecentlyplayedInitial extends RecentlyplayedState {
  @override
  List<Object?> get props => [];
}

class DisplayRecently extends RecentlyplayedState {
  List<RecentlyPlayedModel> recentPlay;
  DisplayRecently({
    required this.recentPlay,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}
