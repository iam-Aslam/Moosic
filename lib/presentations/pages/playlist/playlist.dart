import 'package:flutter/material.dart';

import 'package:moosic/presentations/widgets/common.dart';

import '../../widgets/data.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerpages(context),
              titlesfav(title: 'Playlists'),
              Expanded(
                  child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                    PlaylistNames.length,
                    (index) => playlistgrid(
                        image: PlaylistImages[index],
                        song: PlaylistNames[index])),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
