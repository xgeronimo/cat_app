import 'package:flutter/material.dart';
import 'screens/cat_home_screen.dart';

void main() {
  runApp(CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatHomeScreen(),
    );
  }
}
