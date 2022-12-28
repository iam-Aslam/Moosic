// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    goHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 92, 46, 216),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/images/splash.png'),
                  height: 350,
                  width: 350,
                ),
              ]),
        ),
      ),
    ));
  }

  Future<void> goHome() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.of(context).pushReplacementNamed('home');
  }
}
