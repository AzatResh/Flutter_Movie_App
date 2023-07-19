import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/api_key.dart';
import 'package:flutter_movie/screens/movieDetails.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Favourite extends StatefulWidget{
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => FavouriteState();
}

class FavouriteState extends State<Favourite>{
  late List _topMovies = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My movies"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, 
            icon: const Icon(CupertinoIcons.search)
          )
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _topMovies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (120.0 / 185.0),
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10), 
        itemBuilder:(context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: 
                (context) => MovieDetails(movie:_topMovies[index],)));
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500' + _topMovies[index]['poster_path']),
                    fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}