// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, camel_case_types
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosic/Data/Models/functions/addplaylist.dart';
import 'package:moosic/Data/Models/functions/dbfunctions.dart';
import 'package:moosic/Data/Models/models/playlistmodel.dart';
import 'package:moosic/Data/Models/models/recentlymodel.dart';
import 'package:moosic/Data/Models/models/songsmodel.dart';
import 'package:moosic/presentations/pages/current_playing/current.dart';
import 'package:moosic/presentations/pages/home/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class common extends StatelessWidget {
  const common({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//header
Widget header(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          'MOOSIC',
          style: TextStyle(
              letterSpacing: .5,
              fontSize: 35,
              fontFamily: 'Blanka',
              fontWeight: FontWeight.normal,
              color: Colors.deepPurpleAccent),
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed('search');
        },
        icon: Icon(
          Icons.search_sharp,
          size: 30,
        ),
      )
    ],
  );
}

//header for pages
Widget headerpages(BuildContext context) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 30,
        ),
      ),
    ],
  );
}

//titles
Padding titles({required String title, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Row(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
          ),
        ),
        SizedBox(
          width: 230,
        ),
        InkWell(
          child: Text(
            'See All',
            style: GoogleFonts.lato(
              textStyle: TextStyle(letterSpacing: .5, fontSize: 13),
            ),
          ),
          onTap: () {
            log('Seeing all playlist');
            Navigator.of(context).pushNamed('playlist');
          },
        ),
      ],
    ),
  );
}

//titles library
//titles
Padding titleslib({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
    child: Row(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

//title for favorites
Padding titlesfav({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Row(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
          ),
        ),
        SizedBox(
          width: 210,
        ),
        Icon(
          Icons.more_horiz,
          size: 30,
        ),
      ],
    ),
  );
}

//playlist listview model
InkWell playlist(
    {required String name,
    required String image,
    required BuildContext context}) {
  return InkWell(
    onTap: () => Navigator.of(context).pushNamed('playlist_page'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            image,
            height: 90,
            width: 90,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(letterSpacing: .5, fontSize: 15),
          ),
        )
      ],
    ),
  );
}

//title single
Text titlesingle({required String title}) {
  return Text(
    title,
    style: GoogleFonts.lato(
      textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
    ),
  );
}

//title single with padding left
Padding titlesinglep({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Text(
      title,
      style: GoogleFonts.lato(
        textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
      ),
    ),
  );
}

//main page list tile
InkWell listtile({
  RecentlyPlayedModel? recent,
  //required MostPlayed mostsong,
  required Songs songs,
  required int image,
  required String song,
  required String artist,
  // required String duration,
  required int index,
  required bool isadded,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      log('i am listtile');
      home.currentvalue.value = index;
      current.currentvalue.value = index;
      //setState(() {});
      recent = RecentlyPlayedModel(
        index: index,
        id: songs.id,
        artist: songs.artist,
        duration: songs.duration,
        songname: songs.songname,
        songurl: songs.songurl,
      );
      addRecently(recent!);
      //addMostplayed(index, mostsong);

      Navigator.of(context).pushNamed('current');
    },
    child: Container(
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                child: QueryArtworkWidget(
                  keepOldArtwork: true,
                  artworkBorder: BorderRadius.circular(10),
                  id: image,
                  artworkHeight: 80,
                  artworkWidth: 80,
                  type: ArtworkType.AUDIO,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    child: Text(
                      song,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 140,
                    child: Text(
                      artist,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          letterSpacing: .5,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   duration,
                  //   style: GoogleFonts.roboto(
                  //     textStyle: TextStyle(
                  //         letterSpacing: .5,
                  //         fontSize: 12,
                  //         color: Colors.black38),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_sharp,
                    color: Colors.deepPurpleAccent,
                    size: 45,
                  ),
                  IconButton(
                      onPressed: () {
                        showOptions(context, index);
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

//show dialogue
showOptions(BuildContext context, int index) {
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.deepPurpleAccent,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: 50,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextButton.icon(
                  //     onPressed: () {
                  //       if (checkFavoriteStatus(index, BuildContext)) {
                  //         addfavour(index);
                  //         log('added');
                  //       } else if (!checkFavoriteStatus(index, BuildContext)) {
                  //         //     deletefavourite(index);
                  //       }
                  //       setState(() {});

                  //       Navigator.pop(context);
                  //     },
                  //     icon: (checkFavoriteStatus(index, context))
                  //         ? const Icon(
                  //             Icons.favorite_border_outlined,
                  //             color: Colors.white,
                  //           )
                  //         : Icon(
                  //             Icons.favorite,
                  //             color: Colors.white,
                  //           ),
                  //     label: (checkFavoriteStatus(index, context))
                  //         ? Text(
                  //             'Add to Favourites',
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 17),
                  //           )
                  //         : Text(
                  //             'Remove from Favourites',
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 17),
                  //           )),
                  TextButton.icon(
                      onPressed: () {
                        showPlaylistOptions(context, index);
                      },
                      icon: const Icon(
                        Icons.playlist_add_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Add to Playlist',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  final songbox = SongBox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.deepPurpleAccent,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: 200,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<Box<PlaylistSongs>>(
                      valueListenable: box.listenable(),
                      builder:
                          (context, Box<PlaylistSongs> playlistsongs, child) {
                        List<PlaylistSongs> playlistsong =
                            playlistsongs.values.toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlistsong.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                PlaylistSongs? playsongs =
                                    playlistsongs.getAt(index);
                                List<Songs> playsongdb =
                                    playsongs!.playlistssongs!;
                                List<Songs> songdb = songbox.values.toList();
                                bool isAlreadyAdded = playsongdb.any(
                                    (element) =>
                                        element.id == songdb[songindex].id);
                                if (!isAlreadyAdded) {
                                  playsongdb.add(
                                    Songs(
                                      songname: songdb[songindex].songname,
                                      artist: songdb[songindex].artist,
                                      duration: songdb[songindex].duration,
                                      songurl: songdb[songindex].songurl,
                                      id: songdb[songindex].id,
                                    ),
                                  );
                                }
                                playlistsongs.putAt(
                                    index,
                                    PlaylistSongs(
                                        playlistname:
                                            playlistsong[index].playlistname,
                                        playlistssongs: playsongdb));
                                // ignore: avoid_print
                                print(
                                    'song added to${playlistsong[index].playlistname}');
                                Navigator.pop(context);
                              },
                              title: Text(
                                playlistsong[index].playlistname!,
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

//add playlist naming
showPlaylistOptionsadd(BuildContext context) {
  final myController = TextEditingController();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.deepPurpleAccent,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 250,
        width: vwidth,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'New Playlist',
                    style:
                        GoogleFonts.raleway(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: vwidth * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white10,
                          label: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Enter Playlist Name:',
                              style: GoogleFonts.raleway(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                          // alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: vwidth * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text(
                          'Cancel',
                          style: GoogleFonts.raleway(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: vwidth * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          newplaylist(myController.text);
                          Navigator.pop(context);
                        },
                        label: Text(
                          'Done',
                          style: GoogleFonts.raleway(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

//popup menu for songs
PopupMenuButton<int> popupmenu() {
  return PopupMenuButton<int>(
    itemBuilder: (context) => [
      // PopupMenuItem 1
      PopupMenuItem(
        onTap: () {
          log('Added to favourites');
          // addfavour(context,index,);
        },
        value: 1,
        // row with 2 children
        child: Row(
          children: const [
            Icon(Icons.favorite),
            SizedBox(
              width: 10,
            ),
            Text("Add To Favorites")
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        // row with two children
        child: Row(
          children: const [
            Icon(Icons.add_circle_outline),
            SizedBox(
              width: 10,
            ),
            Text("Add To Playlist")
          ],
        ),
      ),
    ],
  );
}

//favorite gridview functions
Padding favorite({
  required String song,
  required int image,
  required int time,
  required int index,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            home.currentvalue.value = index;
            current.currentvalue.value = index;
            Navigator.of(context).pushNamed('current');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: QueryArtworkWidget(
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(10),
              id: image,
              artworkWidth: 140,
              artworkHeight: 140,
              type: ArtworkType.AUDIO,
            ),
          ),
        ),
        // SizedBox(
        //   height: 0,
        // ),
        Row(
          children: [
            Container(
              width: 112,
              child: Text(
                song,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // PopupMenuButton<int>(
            //   itemBuilder: (context) => [
            //     // PopupMenuItem 1
            //     PopupMenuItem(
            //       onTap: () {
            //         removefavour(index);
            //       },
            //       value: 1,
            //       // row with 2 children
            //       child: Row(
            //         children: const [
            //           Icon(Icons.delete),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text("Remove")
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),

        // Text(
        //   '',
        //   // '04:47 Min',
        //   style: GoogleFonts.lato(
        //     textStyle: TextStyle(
        //         letterSpacing: .5,
        //         fontSize: 12,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black38),
        //   ),
        // )
      ],
    ),
  );
}

//favourite to build dummy datas
Padding favoritedummy(
    {required String song, required int image, required int time}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => log('I am your favorite song'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: QueryArtworkWidget(
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(10),
              id: image,
              artworkWidth: 140,
              artworkHeight: 140,
              type: ArtworkType.AUDIO,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          song,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        // SizedBox(
        //   height: 2,
        // ),
        // Text(
        //   '$time',
        //   // '04:47 Min',
        //   style: GoogleFonts.lato(
        //     textStyle: TextStyle(
        //         letterSpacing: .5,
        //         fontSize: 12,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black38),
        //   ),
        // )
      ],
    ),
  );
}

PopupMenuButton<int> menubarlib({required BuildContext context}) {
  return PopupMenuButton<int>(
    itemBuilder: (context) => [
      // PopupMenuItem 1
      PopupMenuItem(
        value: 1,
        // row with 2 children
        child: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
            Text("Add Songs")
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        // row with two children
        child: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: Text("Settings"),
              onTap: () => Navigator.of(context).pushNamed('settings'),
            )
          ],
        ),
      ),
    ],
  );
}

//library list function
Padding library(
    {required String image,
    required String title,
    required String subtitle,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 15),
    child: Container(
      width: 340,
      height: 110,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              //'assets/images/prettygirl.jpg',
              height: 110,
              width: 110,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                //color: Colors.amberAccent,
                child: Text(
                  title,
                  style: GoogleFonts.sahitya(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.abel(
                  textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

//playlist grid veiw
//favorite gridview functions
Padding playlistgrid({required String song, required String image}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => log('I am your favorite song'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              //'assets/images/default.png',
              height: 140,
              width: 140,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          song,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                letterSpacing: .5, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

//settings widgets
Widget settingselements(
    {required IconData icon,
    required String title,
    required BuildContext context,
    required String page}) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 20),
    child: Container(
      height: 60,
      width: 340,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Icon(
                  icon,
                  // Icons.account_circle_outlined,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  //'Account',
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                if (page == 'exit') {
                  // SystemNavigator.pop();
                  return exit(context);
                } else if (page == 'privacy') {
                  Navigator.of(context).pushNamed('privacy');
                } else if (page == 'terms') {
                  Navigator.of(context).pushNamed('terms');
                } else if (page == 'about') {
                  Navigator.of(context).pushNamed('about');
                }
              },
              icon: Icon(
                Icons.navigate_next_outlined,
                size: 30,
              ))
        ],
      ),
    ),
  );
}

//privacy text
Widget privacy() {
  return Text(
    '''
This privacy policy explains how MOOSIC collects, uses, and shares information about you when you use our app and the choices you have associated with that information.

Information We Collect :

We collect information about you when you use our app, including:

Information you provide to us: When you sign up for an account, we may collect your name, email address, and other contact information.

Information we collect automatically: When you use our app, we may collect information about your device, including your IP address, device type, and operating system. We may also collect information about your usage of the app, such as the pages you visit and the actions you take within the app.

Location information: We may collect information about your location when you use our app, including through the use of GPS, Bluetooth, and other technologies.

Use of Information :

We use the information we collect to provide and improve our app, and for the following purposes:

To provide and personalize our app: We use the information we collect to provide and personalize the app, including to customize the content and recommendations we show you.

To communicate with you: We may use the information we collect to communicate with you, such as to send you updates or notifications about your account or the app.

To analyze and improve our app: We may use the information we collect to understand how people use our app and to identify areas for improvement.

Sharing of Information :

We may share the information we collect as follows:

With service providers: We may share information with third parties that provide services to us, such as hosting and maintenance, analytics, and payment processing.

With legal authorities: We may share information with legal authorities if we are required to do so by law or if we believe it is necessary to protect the rights, property, or safety of our app, users, or others.

Your Choices :

You have the following choices regarding the information we collect and how it is used:

Opting out of location tracking: You can disable location tracking on your device at any time. Please note that some features of our app may not be available if you disable location tracking.

Opting out of email communications: You can opt out of receiving emails from us at any time by following the unsubscribe instructions in the emails we send you.

Deleting your account: You can delete your account at any time by contacting us or using the delete account feature within the app. Please note that some information may remain in our records after you delete your account.

Data Retention :

We will retain the information we collect for as long as your account is active or as needed to provide you with the app. We may also retain and use this information as necessary to comply with legal obligations, resolve disputes, and enforce our agreements.

Changes to This Privacy Policy

We may update this privacy policy from time to time. We will post any updates on this page and encourage you to review the policy periodically. If we make significant changes to the policy, we may also provide additional notice, such as by sending an email or displaying a notice within the app.

Contact Us :

If you have any questions about this privacy policy or the information we collect, please contact us at [contact information].

''',
    style: GoogleFonts.raleway(
      textStyle: TextStyle(
          letterSpacing: .5,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    ),
  );
}

//term text
Widget terms() {
  return Text(
    '''
Terms and Conditions:

By accessing or using our music player app 'MOOSIC', you agree to be bound by these terms and conditions (the "terms"). If you do not agree to these terms, do not use the app.

We reserve the right to change these terms at any time, and you are responsible for reviewing these terms for any updates. Your continued use of the app after any changes have been made constitutes your acceptance of the revised terms.

Use of the App:

The app is intended for personal, non-commercial use. You may not use the app for any illegal or unauthorized purpose. You may not use the app to distribute or download any material that is illegal, copyrighted, or that violates these terms.

We grant you a limited, non-exclusive, non-transferable license to use the app for your personal, non-commercial use. This license does not include the right to sell or distribute the app, or to modify or create derivative works of the app.

Content and Intellectual Property

The app includes content that is owned or licensed by us, including but not limited to text, images, music, and other audio and visual materials. This content is protected by copyright and other intellectual property laws, and you may not use this content except as provided in these terms or with the express written permission of the owner.

The app also includes music and other audio files that are owned or licensed by third parties. We do not claim ownership of these files, and you are responsible for obtaining the necessary permissions to use them.

Accounts and Privacy:

In order to access certain features of the app, you may be required to create an account. You are responsible for maintaining the confidentiality of your account and password, and for all activities that occur under your account.

We respect your privacy and will not share your personal information with third parties, except as required by law or as necessary to provide the app to you. For more information on how we handle your personal information, please see our privacy policy.

Disclaimer of Warranties:

The app is provided on an "as is" and "as available" basis, without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not guarantee that the app will be available at all times or that it will be error-free.

Limitation of Liability:

We will not be liable for any damages arising out of or in connection with your use of the app, including but not limited to direct, indirect, incidental, consequential, or punitive damages. This limitation applies even if we have been advised of the possibility of such damages.

Governing Law:

These terms are governed by the laws of the state of [state], and you agree to submit to the exclusive jurisdiction of the courts located in [county] for any disputes arising out of or in connection with these terms or the app.

Contact Us:

If you have any questions about these terms or the app, please contact us at [contact information].





''',
    style: GoogleFonts.raleway(
      textStyle: TextStyle(
          letterSpacing: .5,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    ),
  );
}

//about us
Widget about() {
  return Text(
    '''
About Us : 

We are a team of passionate music lovers who have come together to create a better music listening experience for you. Our app is designed to make it easy for you to discover new music, create personalized playlists, and enjoy your favorite tracks anytime, anywhere.

We believe in the power of music to bring people together, and we strive to create a welcoming and inclusive community for music fans of all kinds. We are constantly working to improve the app and add new features to enhance your listening experience.

Thank you for choosing [app name] as your go-to music player. We hope you enjoy using it as much as we enjoyed creating it. If you have any feedback or suggestions, we would love to hear from you. Contact us at [contact information].

''',
    style: GoogleFonts.raleway(
      textStyle: TextStyle(
          letterSpacing: .5,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    ),
  );
}

// alert box for exit application
void exit(context) {
  //alert dialog
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'CONFIRM',
            style: GoogleFonts.lato(
              textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
            ),
          ),
          content: Text(
            'Are You Sure To Exit',
            style: GoogleFonts.comfortaa(
              textStyle: TextStyle(
                  letterSpacing: .5, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      });
}
