import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_movie/utils/text.dart';

class TrendingMovies extends StatelessWidget{

  final List trendingMovies;

  const TrendingMovies({super.key, required this.trendingMovies});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ModifiedText(text: 'TrendingMovies', size: 26, color: Colors.white,),
          SizedBox(height: 10),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingMovies.length,
              itemBuilder: (context, index){
                return InkWell(
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
                                          trendingMovies[index]['poster_path']
                              ))
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: ModifiedText(
                            size: 15,
                            text: trendingMovies[index]['title'] != null ? trendingMovies[index]['title']: (trendingMovies[index]['name']!=null ? trendingMovies[index]['name'] : 'Loading'),
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