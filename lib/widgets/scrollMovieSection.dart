import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/screens/movieAbout.dart';

class ScrollMovieSection extends StatelessWidget{

  final List movies;
  final String title;
  final Icon icon;

  const ScrollMovieSection({super.key, required this.movies, required this.icon, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: <Widget>[
                icon,
                SizedBox(width: 10,),
                ModifiedText(text: title, size: 15, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 223, 223, 223),)
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => MovieAbout(movie:movies[index],)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                 'https://image.tmdb.org/t/p/w500' +
                                          movies[index]['poster_path']
                              ))
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                             movies[index]['title'] != null ? 
                              movieTitle(movies[index]['title'], 26): (movies[index]['name']!=null ? 
                              movieTitle(movies[index]['name'], 26) : 'Loading'),
                            style: TextStyle(fontSize: 15, color: Colors.white,),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,)
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


  String movieTitle(String title, int maxLength){
    if(title.length > maxLength){
      return '${title.substring(0, maxLength-1)}...';
    }
    return title;
  }
}