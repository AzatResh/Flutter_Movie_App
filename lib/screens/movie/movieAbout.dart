import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_movie/utils/text.dart';
import 'package:flutter_movie/widgets/starRating.dart';
import 'package:flutter_movie/url.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieAbout extends StatefulWidget{
  final Map movie;

  const MovieAbout({super.key, required this.movie});
  @override
  State<MovieAbout> createState() => MovieAboutState();
}

class MovieAboutState extends State<MovieAbout>{

  List _movieCredits = [];
  String trailerYoutube = '';
  late YoutubePlayerController _controller;

  @override
  initState(){
    _controller = YoutubePlayerController(initialVideoId: '');
    loadCredits();
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadCredits() async {
    final url = Uri.parse(getCredits(widget.movie['id']));
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(!this.mounted) return;
      setState(() {
        _movieCredits = data['cast'];
      });
    } else{
      throw Exception('Failed to load movies.');
    }
  }

  Future<void> loadTrailer() async {
    try{
      final url = Uri.parse(getTrailer(widget.movie['id']));
      final response = await http.get(url);

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        if(!this.mounted) return;

        List movieTrailer = data['results'];
        for (Map trailer in movieTrailer) {
          if (trailer['type'] == 'Trailer') {
            setState(() {
              trailerYoutube = trailer['key'];
            });
            break;
          }
        }
      } 
    }
    catch(_){
      print(_);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: Hive.box('myMovies').listenable(),
        builder: (context, box, child){
          return FutureBuilder(
            future: loadTrailer(),
            builder:(context, snapshot) {
              final isMovieSaved = box.get(widget.movie['id']) != null;
              return SingleChildScrollView(
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
                                        Spacer(flex: 6,),
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
                                        Row(
                                          children: <Widget>[
                                            ModifiedText(text: 'rating', size: 12, color: Colors.grey,),
                                            SizedBox(width: 10,),
                                            ModifiedText(text: 'grade now', size: 12, color: Colors.grey,),
                                          ],),
                                        ModifiedText(text: 'Popularity: ' + widget.movie['popularity'].toString(), size: 15),
                                        ModifiedText(text: 'Date: ' + widget.movie['release_date'].toString(), size: 15),
                                        Spacer(flex: 5,),
                                      ],),),
                                ],)
                            ),
                          )
                        ],
                      )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                            onPressed: () async {
                              const snackBar = SnackBar(
                                  content: Text('Movie trailer not available'),
                                  backgroundColor: CupertinoColors.systemRed,
                                );
                              if (trailerYoutube == '') {
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                showMovieTrailerDialog(context);
                              }
                            },
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
                            icon: Icon(isMovieSaved ? CupertinoIcons.plus_rectangle_fill_on_rectangle_fill : CupertinoIcons.plus_rectangle_on_rectangle,
                              color: isMovieSaved ? CupertinoColors.systemGreen : CupertinoColors.systemGrey,),
                            onPressed: () async{
                              ScaffoldMessenger.of(context).clearSnackBars();
                              if(isMovieSaved){
                                await box.delete(widget.movie['id']);
                              }
                              else{
                                await box.put(widget.movie['id'], widget.movie);
                              }
                            },
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
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: MediaQuery.of(context).size.width,
                      child: ModifiedText(text: "Каст:", size: 18, textAlign: TextAlign.left,),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _movieCredits == null? 0: (_movieCredits.length>10? 10: _movieCredits.length),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    image: DecorationImage(
                                      image: NetworkImage(_movieCredits[index]['profile_path']!=null? 
                                      'https://image.tmdb.org/t/p/w500' + _movieCredits[index]['profile_path']: 'https://image.tmdb.org/t/p/w500//2Stnm8PQI7xHkVwINb4MhS7LOuR.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                ModifiedText(text: _movieCredits[index]['character'], size: 10),
                                ModifiedText(text: _movieCredits[index]['name'], size: 10)
                              ],
                            )
                          );
                        },
                      ),
                    )
                ]
              )
            );
          },
        );
      }    
    ));
  }

  void showMovieTrailerDialog(BuildContext context) {
    _controller = YoutubePlayerController(
      initialVideoId: trailerYoutube,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          content: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: Colors.orange,
                  handleColor: Colors.orangeAccent,
                ),
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
        );
      },
    );
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