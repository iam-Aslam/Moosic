import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Bussiness%20Logic/allsongs_bloc/allsongs_bloc.dart';
import 'package:moosic/Bussiness%20Logic/mostplayed_bloc/mostplayed_bloc.dart';
import 'package:moosic/Bussiness%20Logic/playlist_bloc/playlist_bloc.dart';
import 'package:moosic/Bussiness%20Logic/recentyplayed_bloc/recentlyplayed_bloc.dart';
import 'package:moosic/Data/Models/functions/dbfunctions.dart';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/Data/Models/models/mostplayed.dart';
import 'package:moosic/Data/Models/models/playlistmodel.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/pages/home/home.dart';
import 'package:moosic/presentations/pages/library/most_played/most_played.dart';
import 'package:moosic/presentations/pages/library/recent_played/recent_played.dart';
import 'package:moosic/presentations/pages/playlist/playlist.dart';
import 'package:moosic/presentations/pages/search/search.dart';
import 'package:moosic/presentations/pages/settings/about_us/about.dart';
import 'package:moosic/presentations/pages/settings/privacy_policy/privacy.dart';
import 'package:moosic/presentations/pages/settings/settings.dart';
import 'package:moosic/presentations/pages/settings/terms_and_conditions/terms.dart';
import 'package:moosic/presentations/pages/splash/splash.dart';
import 'Bussiness Logic/favourites_bloc/favourites_bloc.dart';
import 'presentations/pages/current_playing/current.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);
  Hive.registerAdapter(favouritesAdapter());
  openfavourite();
  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();
  Hive.registerAdapter(RecentlyPlayedModelAdapter());
  openrecentlyplayeddb();
  Hive.registerAdapter(PlaylistSongsAdapter());
  await Hive.openBox<PlaylistSongs>('playlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllsongsBloc(),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(),
        ),
        BlocProvider(
          create: (context) => RecentlyplayedBloc(),
        ),
        BlocProvider(
          create: (context) => MostplayedBloc(),
        ),
        BlocProvider(
          create: (context) => PlaylistBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Moosic',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const splash_screen(),
          routes: {
            'home': (context) => const Home(),
            'current': (context) => const current(),
            'most': (context) => const MostPlayedPage(),
            'recent': (context) => Recentlyplayed(),
            'playlist': (context) => Playlist(),
            'settings': (context) => const Settings(),
            'privacy': (context) => const Privacy(),
            'terms': (context) => const TermsandConditions(),
            'about': (context) => const AboutUs(),
            'search': (context) => const SearchScreen(),
          }),
    );
  }
}
