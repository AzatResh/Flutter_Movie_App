import 'package:flutter/material.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/widgets/starRating.dart';

class MovieAbout extends StatelessWidget{
  
  final Map movie;

  const MovieAbout({super.key, required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child:ClipPath(
                      clipper: CurveClipper(),
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500' + movie['backdrop_path'],
                            fit: BoxFit.cover,
                          ),
                        )
                      )
                    ),

                    Positioned(
                      top: 200,
                      left: 0,
                      child: Container(
                        height: 220,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 180,
                              width: 120,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500' + movie['poster_path'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width-140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 22,),
                                  ModifiedText(
                                    text: movie['title'] != null ? movie['title']: (movie['name']!=null ? movie['name'] : 'Loading'), 
                                    size: 18,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,),
                                  Row(
                                    children: <Widget>[
                                      ModifiedText(text: movie['vote_average'].toString(), size: 20, color: Color.fromARGB(255, 255, 215, 15),),
                                      SizedBox(width: 10,),
                                      StarRating(value: (movie['vote_average']/2).toInt())
                                    ],),
                                  const Row(
                                    children: <Widget>[
                                      ModifiedText(text: 'rating', size: 12, color: Colors.grey,),
                                      SizedBox(width: 10,),
                                      ModifiedText(text: 'grade now', size: 12, color: Colors.grey,),
                                    ],),
                                  ModifiedText(text: 'Popularity: ' + movie['popularity'].toString(), size: 15),
                                  ModifiedText(text: 'Date: ' + movie['release_date'].toString(), size: 15),
                                  Spacer(),
                                ],),),
                          ],)
                      ),
                    )
                  ],
                )),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ModifiedText(text: "Описание:", size: 18, textAlign: TextAlign.left,),
                    SizedBox(height: 12,),
                    Text(movie['overview'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.left,),
                  ],
                ) 
              ),
          ]
        )
      )
    ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 20;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}