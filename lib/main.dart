import 'package:expense/screens/home_page.dart';
import 'package:expense/screens/splash.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splash_screen()
    );
  }
}
