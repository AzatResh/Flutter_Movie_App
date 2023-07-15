import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'api_key.dart';

import 'package:flutter_movie/widgets/scrollMovieSection.dart';
import 'package:flutter_movie/widgets/tvSection.dart';
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
      home: const MyHomePage(title: 'Flutter Movie App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List trendingMovies = new List.empty();
  List topMovies = new List.empty();
  List tvMovies = new List.empty();

  @override
  initState(){
    loadMovies();
    super.initState();
  }
  
  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(tmdbApiKey, tmdbV4Key),
    logConfig: const ConfigLogger(
      showLogs: true,//must be true than only all other logs will be shown
      showErrorLogs: true,
      ),
    );

    Map resultTrending = await tmdbWithCustomLogs.v3.trending.getTrending(mediaType: MediaType.all, timeWindow: TimeWindow.day, language: 'ru');
    Map resultTop = await tmdbWithCustomLogs.v3.movies.getTopRated(language: 'ru');
    Map resultTv = await tmdbWithCustomLogs.v3.tv.getPopular(language: 'ru');
    setState(() {
      trendingMovies = resultTrending['results'];
      topMovies = resultTop['results'];
      tvMovies = resultTv['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: Container(
        child: BottomNavBar(),
      ) 
    );
  }
}
