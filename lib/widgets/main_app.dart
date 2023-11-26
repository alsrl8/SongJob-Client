import 'package:flutter/material.dart';
import 'home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Job',
      theme: ThemeData.dark().copyWith(
        highlightColor: const Color.fromRGBO(0, 0, 0, 125),
        primaryColor: Colors.deepPurple,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.deepOrangeAccent,
        ),
      ),
      home: const Home(),
    );
  }
}
