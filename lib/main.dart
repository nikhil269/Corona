import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona',
      theme: ThemeData(brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}
