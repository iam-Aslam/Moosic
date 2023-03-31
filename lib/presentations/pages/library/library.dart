// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:moosic/Data/Models/models/favouriteModel.dart';
import 'package:moosic/presentations/pages/current_playing/current.dart';
import 'package:moosic/presentations/widgets/common.dart';
import 'package:moosic/presentations/widgets/data.dart';

class libraries extends StatefulWidget {
  const libraries({super.key});

  @override
  State<libraries> createState() => _librariesState();
}

class _librariesState extends State<libraries> {
  final box = FavouriteBox.getInstance();
  late List<favourites> favourite = box.values.toList();
  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    //size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: height / 1.26,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black26),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(context),
              titlesinglep(title: 'Your Library'),
              Expanded(
                child: ListView.separated(
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).pushNamed('playlist');
                            } else if (index == 1) {
                              Navigator.of(context).pushNamed('recent');
                            } else if (index == 2) {
                              Navigator.of(context).pushNamed('most');
                            }
                          },
                          child: library(
                              context: context,
                              image: lib_img[index],
                              title: lib_titles[index],
                              subtitle: lib_counts[index]),
                        )),
                    separatorBuilder: ((context, index) => SizedBox(
                          width: 0,
                        )),
                    itemCount: lib_titles.length),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
