// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:moosic/presentations/widgets/common.dart';
import '../../widgets/data.dart';

class favorites extends StatelessWidget {
  const favorites({super.key});

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(context),
              titlesfav(title: 'Favorites'),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    favorsong.length,
                    (index) => favorite(
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
