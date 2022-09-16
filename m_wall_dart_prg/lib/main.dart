import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(
      title: 'Dart Program',
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void thenCatch() {
    print('Started');
    Future.delayed(Duration(seconds: 2)).then((_) {
      print('Completed');
    }).catchError((e) {
      print('failed: ${e.toString()}');
    });
  }

  Future<void> asyncAwait() async {
    print('Started');
    try {
      await Future.delayed(Duration(seconds: 2));
      print('Completed first');
      await Future.delayed(Duration(seconds: 1));
      print('Completed second');
    } catch (e) {
      print('failed: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("${asyncAwait()}"),
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Async await"),
            ),
          )
        ],
      ),
    );
  }
}
