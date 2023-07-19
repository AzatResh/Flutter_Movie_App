import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/api_key.dart';
import 'package:flutter_movie/screens/movieDetails.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Popular extends StatefulWidget{
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => PopularState();
}

class PopularState extends State<Popular>{
  late List _topMovies = [];

  @override
  void initState() {
    loadMovies();
    super.initState();
  }
  
  Future<void> loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(tmdbApiKey, tmdbV4Key),
    logConfig: const ConfigLogger(
      showLogs: true,//must be true than only all other logs will be shown
      showErrorLogs: true,
      ),
    );

    Map resultTop = await tmdbWithCustomLogs.v3.movies.getTopRated(language: 'ru');
    setState(() {
      _topMovies = resultTop['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular movies"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, 
            icon: const Icon(CupertinoIcons.search)
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadMovies,
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _topMovies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (120.0 / 185.0),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10), 
          itemBuilder:(context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => MovieDetails(movie:_topMovies[index],)));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500' + _topMovies[index]['poster_path']),
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}