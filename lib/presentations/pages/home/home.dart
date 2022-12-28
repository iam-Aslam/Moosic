// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:moosic/presentations/pages/favorites/favorites.dart';
import 'package:moosic/presentations/pages/home/songs.dart';
import 'package:moosic/presentations/pages/library/library.dart';
import 'package:moosic/presentations/pages/settings/settings.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentselected = 0;
  final pages = const [
    songs(),
    favorites(),
    libraries(),
    settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: pages[currentselected],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: currentselected,
          onTap: (value) => setState(() {
            currentselected = value;
          }),
          height: 60,
          buttonBackgroundColor: Colors.deepPurpleAccent,
          color: Colors.deepPurpleAccent,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.favorite,
              size: 30,
            ),
            Icon(
              Icons.library_music,
              size: 30,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: InkWell(
          onTap: () {
            log('hi i am inkwell');
            Navigator.of(context).pushNamed('current');
          },
          child: Container(
            width: 466,
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/default.jpg'),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Times for the Anxious',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'David Mansion',
                      style: TextStyle(fontSize: 13, color: Colors.black38),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    log('hi i am previous');
                  },
                  icon: Icon(
                    Icons.skip_previous_outlined,
                    color: Colors.deepPurpleAccent,
                    size: 36,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    log('hi i am play');
                  },
                  icon: Icon(
                    Icons.play_circle_sharp,
                    color: Colors.deepPurpleAccent,
                    size: 36,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    log('hi i am next');
                  },
                  icon: Icon(
                    Icons.skip_next_outlined,
                    color: Colors.deepPurpleAccent,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
