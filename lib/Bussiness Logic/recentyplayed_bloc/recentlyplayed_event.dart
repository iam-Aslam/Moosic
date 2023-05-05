// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recentlyplayed_bloc.dart';

@immutable
abstract class RecentlyplayedEvent {}

class GetRecentlyPlayed extends RecentlyplayedEvent {
  GetRecentlyPlayed();
}

class AddToRecentlyPlayed extends RecentlyplayedEvent {
  final RecentlyPlayedModel recentlyPlayedModel;
  AddToRecentlyPlayed({
    required this.recentlyPlayedModel,
  });
}
