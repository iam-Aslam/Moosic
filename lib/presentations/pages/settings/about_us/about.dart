import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../widgets/common.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          headerpages(context),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titlesingle(title: 'About Us'),
                    ],
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 15),
                  child: about(),
                )),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
