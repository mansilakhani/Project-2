import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Duration duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: _heigth,
        width: _width,
        color: Colors.black,
        // color: const Color(0xff2b3e4f),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/logo.png",
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              // backgroundColor: Color(0xff3cacc4),
              backgroundColor: Colors.redAccent,
              strokeWidth: 1.3,
              // color: Colors.white.withOpacity(0.7),
              color: Color(0xff3cacc4),
            )
          ],
        ),
      ),
    );
  }
}
