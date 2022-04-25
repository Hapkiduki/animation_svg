import 'package:flutter/material.dart';

import 'animation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const items = [
    'assets/Vector.svg',
    'assets/Vector-2.svg',
    'assets/Vector-3.svg',
    'assets/Vector-4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationPage(
        //color: Colors.red,
        items: items,
      ),
    );
  }
}
