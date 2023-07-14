import 'package:flutter/material.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/pages/movieAbout.dart';

class TVSection extends StatelessWidget {
  final List tv;

  const TVSection({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Popular TV Shows',
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              // color: Colors.red,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: 
                          (context) => MovieAbout(movie: tv[index],)));
                      },
                      child:Container(
                      padding: EdgeInsets.all(5),
                      // color: Colors.green,
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    tv[index]['backdrop_path']!=null?
                                      'https://image.tmdb.org/t/p/w500' +
                                          tv[index]['backdrop_path']: ''),
                                  fit: BoxFit.cover),
                            ),
                            height: 140,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: ModifiedText(
                                size: 15,
                                text: tv[index]['original_name'] != null
                                    ? tv[index]['original_name']
                                    : 'Loading'),
                          )
                        ],
                      ),
                    ));
                  }))
        ],
      ),
    );
  }
}