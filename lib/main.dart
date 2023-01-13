import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/functions/dbfunctions.dart';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/Data/Models/models/playlistmodel.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/pages/home/home.dart';
import 'package:moosic/presentations/pages/library/downloads/download_songs.dart';
import 'package:moosic/presentations/pages/library/most_played/most_played.dart';
import 'package:moosic/presentations/pages/library/recent_played/recent_played.dart';
import 'package:moosic/presentations/pages/liked_songs/liked.dart';
import 'package:moosic/presentations/pages/playlist/playlist.dart';
import 'package:moosic/presentations/pages/search/search.dart';
import 'package:moosic/presentations/pages/settings/about_us/about.dart';
import 'package:moosic/presentations/pages/settings/privacy_policy/privacy.dart';
import 'package:moosic/presentations/pages/settings/settings.dart';
import 'package:moosic/presentations/pages/settings/terms_and_conditions/terms.dart';
import 'package:moosic/presentations/pages/splash/splash.dart';
import 'presentations/pages/current_playing/current.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);
  Hive.registerAdapter(favouritesAdapter());
  openfavourite();
  Hive.registerAdapter(RecentlyPlayedAdapter());
  openrecentlyplayeddb();
  Hive.registerAdapter(PlaylistSongsAdapter());
  await Hive.openBox<PlaylistSongs>('playlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moosic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const splash_screen(),
        routes: {
          'home': (context) => home(),
          'current': (context) => const current(),
          'liked': (context) => const LikedSongs(),
          'most': (context) => const MostPlayed(),
          'recent': (context) => const Recentlyplayed(),
          'download': (context) => const Downloads(),
          'playlist': (context) => const Playlist(),
          'settings': (context) => const settings(),
          'privacy': (context) => const Privacy(),
          'terms': (context) => const TermsandConditions(),
          'about': (context) => const AboutUs(),
          'search': (context) => const SearchScreen(),
        });
  }
}
