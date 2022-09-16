import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_wall_educational_website/screens/clever.dart';
import 'package:m_wall_educational_website/screens/homepage.dart';
import 'package:m_wall_educational_website/screens/javatpoint.dart';
import 'package:m_wall_educational_website/screens/seesaw.dart';
import 'package:m_wall_educational_website/screens/tutorailspoint.dart';
import 'package:m_wall_educational_website/screens/w3school.dart';
import 'package:m_wall_educational_website/screens/wikipedia.dart';
import 'package:m_wall_educational_website/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash_screen',
    routes: {
      '/': (context) => const HomePage(),
      'w3school': (conntext) => const W3School_Page(),
      'javatpoint': (context) => const JavaTpoint_Page(),
      'wikipedia': (context) => const WikiPedia_Page(),
      'clever': (context) => const Clever_Page(),
      'seesaw': (context) => const Seesaw_Page(),
      'tutorailspoint': (context) => const Tutorialspoint_Page(),
      'splash_screen': (context) => const SplashScreenPage(),
    },
  ));
}
