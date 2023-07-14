import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/pages/movieAbout.dart';

class ScrollMovieSection extends StatelessWidget{

  final List movies;
  final String title;

  const ScrollMovieSection({super.key, required this.movies, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ModifiedText(text: title, size: 26, color: Colors.white,),
          SizedBox(height: 10),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: 
                      (context) => MovieAbout(movie: movies[index],)));
                  },
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                 'https://image.tmdb.org/t/p/w500' +
                                          movies[index]['poster_path']
                              ))
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: ModifiedText(
                            size: 15,
                            text: movies[index]['title'] != null ? movies[index]['title']: (movies[index]['name']!=null ? movies[index]['name'] : 'Loading'),
                            color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )


    );
  }

}