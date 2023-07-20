import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie/screens/movieDetails.dart';

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
    final url = Uri.parse(getSimilar(widget.movieId));
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(!this.mounted) return;
      setState(() {
        movies = data['results'];
      });
    } else{
      throw Exception('Failed to load movies.');
    }
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
