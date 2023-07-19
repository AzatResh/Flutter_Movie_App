import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/api_key.dart';
import 'package:flutter_movie/screens/movieDetails.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Similar extends StatefulWidget{
  final int movieId;

  const Similar({super.key, required this.movieId});
  @override
  State<Similar> createState() => SimilarState();
}

class SimilarState extends State<Similar> {

  late List movies = [];

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

    Map result = await tmdbWithCustomLogs.v3.movies.getSimilar(widget.movieId);
    setState(() {
      movies = result['results'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: loadMovies,
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (120.0 / 185.0),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10), 
          itemBuilder:(context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => MovieDetails(movie: movies[index],)));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(movies[index]['poster_path'] != null?
                          'https://image.tmdb.org/t/p/w500' + movies[index]['poster_path']: 
                          'https://image.tmdb.org/t/p/w500/vBP5xZYGI88dOilwZdxVCn2EjqJ.jpg'),
                      fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
