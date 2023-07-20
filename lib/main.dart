import 'package:flutter/material.dart';
import 'package:flutter_movie/navigation/bottomNavBar.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myMovies');

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