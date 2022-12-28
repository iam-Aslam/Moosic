import 'package:flutter/material.dart';
import 'package:moosic/presentations/widgets/common.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

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
                      titlesingle(title: 'Privacy & Policy'),
                    ],
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 15),
                  child: privacy(),
                )),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
