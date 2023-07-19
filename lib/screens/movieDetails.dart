import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/movie/movieAbout.dart';
import 'package:flutter_movie/screens/movie/similar.dart';
import 'package:flutter_movie/screens/movie/reviews.dart';

class MovieDetails extends StatefulWidget{
  final Map movie;

  const MovieDetails({super.key, required this.movie});
  @override
  State<MovieDetails> createState() => MovieAboutState();
}

class MovieAboutState extends State<MovieDetails> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  List<Tab> tabs = [
    const Tab(text: 'About',),
    const Tab(text: 'Reviews',),
    const Tab(text: 'Similar',),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.movie['title']),
          leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop();
                }, 
              );
            },
          )
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 42,
              color: Colors.black,
              child: TabBar(
                tabs: tabs,
                controller: _tabController,
                indicatorColor: Colors.red,
                labelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                indicatorWeight: 3,
              ),
            ),
            Expanded(
              child: 
                TabBarView(
                  controller: _tabController,
                  children: [
                    MovieAbout(movie: widget.movie),
                    Reviews(movieId: widget.movie['id']),
                    Similar(movieId: widget.movie['id'])
                  ],
              ))
          ],
        ),
    );
  }
}