import 'package:customAnimations/presentation/pages/animations_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Custom animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationsPage(),
    );
  }
}
