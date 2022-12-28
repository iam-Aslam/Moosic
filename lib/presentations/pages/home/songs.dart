// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import '../../widgets/common.dart';
import '../../widgets/data.dart';

class songs extends StatelessWidget {
  const songs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: 690,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black26),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        titles(title: 'Playlists', context: context),
                        Container(
                          height: 130,
                          child: Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 15),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => playlist(
                                    context: context,
                                    name: PlaylistNames[index],
                                    image: PlaylistImages[index]),
                                itemCount: PlaylistNames.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 20, top: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.black26),
                              ),
                            ),
                            width: 400,
                            height: 466,
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titlesingle(title: 'Songs'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: ((context, index) {
                                              return listtile(
                                                image: SongImages[index],
                                                song: SongNames[index],
                                                artist: Songartists[index],
                                                duration: Songtime[index],
                                              );
                                            }),
                                            separatorBuilder:
                                                ((context, index) => SizedBox(
                                                      height: 10,
                                                    )),
                                            itemCount: SongImages.length))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
