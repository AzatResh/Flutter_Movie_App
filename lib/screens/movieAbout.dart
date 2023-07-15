import 'package:flutter/material.dart';
import 'package:flutter_movie/utils/text.dart';

class MovieAbout extends StatelessWidget{
  
  final Map movie;

  const MovieAbout({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500' + movie['backdrop_path'],
                      fit: BoxFit.cover,
                    ),
                  )),
                ],
              )),
              Container(
                padding: EdgeInsets.all(10),
                child: ModifiedText(text: movie['title'] != null ? movie['title']: (movie['name']!=null ? movie['name'] : 'Loading'), size: 20)
              ),
              Container(
                child: ModifiedText(text: '⭐ Average Rating - ' + movie['vote_average'].toString(), size: 15),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 100,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500' + movie['poster_path'],
                    ),
                  ),
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: ModifiedText(text: movie['overview'], size: 15,),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ModifiedText(text: 'Releasing On: ' + (movie['release_date']!=null ? movie['release_date']: 'No Date'), size: 14)
              ),
          ]
        )
      )
    );
  }
}