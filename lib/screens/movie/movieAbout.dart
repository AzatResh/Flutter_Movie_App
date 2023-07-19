import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/widgets/starRating.dart';

class MovieAbout extends StatefulWidget{
  final Map movie;

  const MovieAbout({super.key, required this.movie});
  @override
  State<MovieAbout> createState() => MovieAboutState();
}

class MovieAboutState extends State<MovieAbout>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 370,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child:ClipPath(
                      clipper: CurveClipper(),
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' + widget.movie['backdrop_path'],
                              ),
                              colorFilter: ColorFilter.mode(
                                Colors.black26,
                                BlendMode.darken
                              )
                          )),
                        )
                      )
                    ),

                    Positioned(
                      top: 170,
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
                                'https://image.tmdb.org/t/p/w500' + widget.movie['poster_path'],
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
                                    text: widget.movie['title'] != null ? widget.movie['title']: (widget.movie['name']!=null ? widget.movie['name'] : 'Loading'), 
                                    size: 18,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,),
                                  Row(
                                    children: <Widget>[
                                      ModifiedText(text: widget.movie['vote_average'].toString(), size: 20, color: Color.fromARGB(255, 255, 215, 15),),
                                      SizedBox(width: 10,),
                                      StarRating(value: (widget.movie['vote_average']/2).toInt())
                                    ],),
                                  const Row(
                                    children: <Widget>[
                                      ModifiedText(text: 'rating', size: 12, color: Colors.grey,),
                                      SizedBox(width: 10,),
                                      ModifiedText(text: 'grade now', size: 12, color: Colors.grey,),
                                    ],),
                                  ModifiedText(text: 'Popularity: ' + widget.movie['popularity'].toString(), size: 15),
                                  ModifiedText(text: 'Date: ' + widget.movie['release_date'].toString(), size: 15),
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
                    Text(widget.movie['overview'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.left,),
                  ],
                ) 
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: CupertinoColors.destructiveRed,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: Text(
                        'Watch Trailer',
                        style: TextStyle(fontSize: 14, color: CupertinoColors.destructiveRed),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:  CupertinoColors.systemGrey
                      )
                    ),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.plus_rectangle_on_rectangle, color: CupertinoColors.systemGrey,),
                      onPressed: (){},
                    )
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.reply,
                        color: CupertinoColors.systemGrey,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
          ]
        )
      )
    ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 45;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight - 55);
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