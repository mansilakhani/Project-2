import 'package:flutter/material.dart';

import '../globals.dart';

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
          "Educational websites ",
          style: TextStyle(fontSize: 22),
        ),
        leading: Image.asset(
          'assets/images/web-education-logo.png',
          scale: 8,
          color: Colors.tealAccent.withOpacity(0.5),
          // color: Colors.tealAccent.withOpacity(0.8),
        ),
      ),
      body: Column(
          children: appslist
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Card(
                      elevation: 2,
                      color: Colors.tealAccent.withOpacity(0.48),
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
