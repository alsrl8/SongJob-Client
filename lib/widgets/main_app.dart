import 'package:flutter/material.dart';
import 'package:song_job/widgets/home.dart';

void main() {
  runApp(const MainApp());
}

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
          background: Colors.deepOrange,
        ),
      ),
      home: const BaseHome(),
    );
  }
}

class BaseHome extends StatelessWidget {
  const BaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Home(),
    );
  }
}
