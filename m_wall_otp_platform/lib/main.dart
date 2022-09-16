import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_wall_otp_platform/screens/amazon.dart';
import 'package:m_wall_otp_platform/screens/disneyplushotstar.dart';
import 'package:m_wall_otp_platform/screens/homepage.dart';
import 'package:m_wall_otp_platform/screens/netflix.dart';
import 'package:m_wall_otp_platform/screens/primevideo.dart';
import 'package:m_wall_otp_platform/screens/sonyliv.dart';
import 'package:m_wall_otp_platform/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    routes: {
      '/': (context) => const HomePage(),
      'netflix': (context) => const Netflix(),
      'amazon': (context) => const Amazon(),
      'disneyplushotstar': (context) => const DisneyplusHotstar(),
      'sonyliv': (context) => const SonyLIV(),
      'primevideo': (context) => const PrimeVideo(),
      'splashscreen': (context) => const SplashScreenPage(),
    },
  ));
}
