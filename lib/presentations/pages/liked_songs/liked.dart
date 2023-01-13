import 'package:flutter/material.dart';

import '../../widgets/common.dart';
import '../../widgets/data.dart';

class LikedSongs extends StatelessWidget {
  const LikedSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        //height: double.infinity,
        // decoration: const BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(width: 1.0, color: Colors.black26),
        //   ),
        //   color: Colors.white,
        // ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerpages(context),
              titlesfav(title: 'Favorites'),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    favorsong.length,
                    (index) => favoritedummy(
                        song: favorsong[index],
                        image: favorimg[index],
                        time: favortime[index]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
