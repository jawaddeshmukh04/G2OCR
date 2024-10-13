import 'package:flutter/material.dart';
import 'package:g2ocr/pages/home.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}
