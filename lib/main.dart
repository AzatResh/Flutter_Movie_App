import 'package:flutter/material.dart';
import 'package:flutter_movie/navigation/bottomNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: BottomNavBar(),
    );
  }
}