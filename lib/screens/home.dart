// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/scrollMovieSection.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_movie/widgets/postersSection.dart';

import '../api_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List _trendingMovies, _nowPlayingMovies, _comingSoonMovies;

  @override
  initState(){
    _trendingMovies = _nowPlayingMovies = _comingSoonMovies = [];
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
    Map resultNowPlaying = await tmdbWithCustomLogs.v3.movies.getNowPlaying(language: 'ru');
    Map resultComingSoon = await tmdbWithCustomLogs.v3.movies.getUpcoming(language: 'ru');
    
    setState(() {
      _trendingMovies = resultTrending['results'];
      _nowPlayingMovies = resultNowPlaying['results'];
      _comingSoonMovies = resultComingSoon['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        appBar: AppBar(title: Text("Home"),
        centerTitle: true,
        actions:  [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PosterSection(
                movies: _trendingMovies
              ),
              SizedBox(height: 10,),  
              ScrollMovieSection(
                movies: _nowPlayingMovies, 
                icon: Icon(CupertinoIcons.play_circle, color: const Color.fromARGB(255, 223, 223, 223),), 
                title: "Now Playing"),  
              ScrollMovieSection(
                movies: _comingSoonMovies, 
                icon: Icon(CupertinoIcons.calendar, color: const Color.fromARGB(255, 223, 223, 223),), 
                title: "Coming soon"),
              SizedBox(height: 10,),
            ]),
        ),)
    );
  }
}
