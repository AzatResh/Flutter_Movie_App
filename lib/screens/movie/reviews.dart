import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/url.dart';

class Reviews extends StatefulWidget{
  final int movieId;

  const Reviews({super.key, required this.movieId});
  @override
  State<Reviews> createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  List movieReviews = [];
  
  Future<void> loadReviews() async {
    final url = Uri.parse(getReviews(widget.movieId));
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(!this.mounted) return;
      setState(() {
        movieReviews = data['results'];
      });
    }
    else{
      throw Exception('Failed to load movies.');
    }
  }

  @override
  void initState() {
    loadReviews();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadReviews,
      child: movieReviews.length>0? ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: movieReviews.length,
        itemBuilder:(context, index) {
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: (movieReviews[index]['author_details']['avatar_path'] != null && (Uri.parse(movieReviews[index]['author_details']['avatar_path'].substring(1, movieReviews[index]['author_details']['avatar_path'].length)).isAbsolute) != true)
                          ? NetworkImage('https://image.tmdb.org/t/p/w500' + movieReviews[index]['author_details']['avatar_path'])
                          : (movieReviews[index]['author_details']['avatar_path'] != null && Uri.parse(movieReviews[index]['author_details']['avatar_path'].substring(1, movieReviews[index]['author_details']['avatar_path'].length)).isAbsolute) != false
                          ? NetworkImage(movieReviews[index]['author_details']['avatar_path'].substring(1, movieReviews[index]['author_details']['avatar_path'].length))
                          : NetworkImage('https://image.tmdb.org/t/p/w500//2Stnm8PQI7xHkVwINb4MhS7LOuR.jpg'),
                  fit: BoxFit.fill)
              ),
            ),
            title: Text(
                  movieReviews[index]['content'],
                  maxLines: 5,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
            subtitle: Text(
              movieReviews[index]['author'],
              style: const TextStyle(fontSize: 13),   
            )
          );
        },
      ):
        Container(
          alignment: Alignment.center,
          child: Text("Nothing here", style: TextStyle(fontSize: 18),),
        ),
    );
  }
}
