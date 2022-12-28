import 'package:flutter/material.dart';
import 'package:moosic/presentations/pages/home/home.dart';
import 'package:moosic/presentations/pages/library/downloads/download_songs.dart';
import 'package:moosic/presentations/pages/library/most_played/most_played.dart';
import 'package:moosic/presentations/pages/library/recent_played/recent_played.dart';
import 'package:moosic/presentations/pages/liked_songs/liked.dart';
import 'package:moosic/presentations/pages/playlist/playlist.dart';
import 'package:moosic/presentations/pages/playlist/single_playlist/current_playlist.dart';
import 'package:moosic/presentations/pages/search/search.dart';
import 'package:moosic/presentations/pages/settings/about_us/about.dart';
import 'package:moosic/presentations/pages/settings/account/account.dart';
import 'package:moosic/presentations/pages/settings/privacy_policy/privacy.dart';
import 'package:moosic/presentations/pages/settings/settings.dart';
import 'package:moosic/presentations/pages/settings/terms_and_conditions/terms.dart';
import 'package:moosic/presentations/pages/splash/splash.dart';
import 'presentations/pages/current_playing/current.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const splash_screen(),
        routes: {
          'home': (context) => const home(),
          'current': (context) => const current(),
          'liked': (context) => const LikedSongs(),
          'most': (context) => const MostPlayed(),
          'recent': (context) => const RecentlyPlayed(),
          'download': (context) => const Downloads(),
          'playlist': (context) => const Playlist(),
          'settings': (context) => const settings(),
          'account': (context) => const Account(),
          'privacy': (context) => const Privacy(),
          'terms': (context) => const TermsandConditions(),
          'about': (context) => const AboutUs(),
          'playlist_page': (context) => const CurrentPlaylist(),
          'search': (context) => const SearchScreen(),
        });
  }
}
