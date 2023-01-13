import 'package:flutter/material.dart';
import 'package:moosic/presentations/widgets/common.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SafeArea(
            child: Scaffold(
      body: Container(
        width: double.infinity,
        height: 690,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(context),
              titlesfav(title: 'Settings'),
              settingselements(
                  icon: Icons.lock,
                  context: context,
                  title: 'Privacy & Policy',
                  page: 'privacy'),
              settingselements(
                  icon: Icons.privacy_tip_outlined,
                  context: context,
                  title: 'Terms & Conditions',
                  page: 'terms'),
              settingselements(
                  icon: Icons.question_mark_sharp,
                  context: context,
                  title: 'About Us',
                  page: 'about'),
              settingselements(
                  icon: Icons.share,
                  context: context,
                  title: 'Share App',
                  page: 'share'),
              settingselements(
                  icon: Icons.exit_to_app,
                  context: context,
                  title: 'Exit App',
                  page: 'exit'),
            ],
          ),
        ),
      ),
    )));
  }
}
