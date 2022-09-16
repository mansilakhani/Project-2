import 'package:flutter/material.dart';
import 'package:m_wall_otp_platform/globals/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "OTP Platforms ",
          style: TextStyle(fontSize: 22),
        ),
        leading: Image.asset(
          'assets/image/logo.png',

          //color: Colors.tealAccent.withOpacity(0.8),
        ),
      ),
      body: Column(
          children: weblist
              .map((e) => Padding(
                    padding: const EdgeInsets.only(
                        top: 55, left: 30, right: 30, bottom: 0),
                    child: Card(
                      elevation: 2,
                      color: e['color'],
                      child: ListTile(
                        title: Center(
                          child: Text(
                            e['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(e['route']);
                        },
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
