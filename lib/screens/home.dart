// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie/widgets/scrollMovieSection.dart';
import 'package:flutter_movie/widgets/postersSection.dart';
import 'package:flutter_movie/url.dart';

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
    _getTrendingMovies();
    _getNowPlayingMovies();
    _getComingSoonMovies();
    super.initState();
  }
  
  Future<void> _getTrendingMovies() async{
    final url = Uri.parse(getTrending);
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        _trendingMovies = data['results'];
      });
    } else {
      throw Exception('Failed to load movies.');
    }
  }

  Future<void> _getNowPlayingMovies() async{
    final url = Uri.parse(getNowPlaying);
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        _nowPlayingMovies = data['results'];
      });
    } else {
      throw Exception('Failed to load movies.');
    }
  }

  Future<void> _getComingSoonMovies() async{
    final url = Uri.parse(getUpcoming);
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        _comingSoonMovies = data['results'];
      });
    } else {
      throw Exception('Failed to load movies.');
    }
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
