import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_movie/screens/movieDetails.dart';

class Favourite extends StatefulWidget{
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => FavouriteState();
}

class FavouriteState extends State<Favourite>{
  late List movies = [];

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
      body: ValueListenableBuilder(
        valueListenable: Hive.box('myMovies').listenable(),
        builder: (context, box, child) {
          var box = Hive.box('myMovies');
          movies = box.values.toList();
          if(movies.isNotEmpty){
            return GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (120.0 / 185.0),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10), 
              itemBuilder:(context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: 
                      (context) => MovieDetails(movie:movies[index],)));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500' + movies[index]['poster_path']),
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Container(
              alignment: Alignment.center,
              child: Text("Nothing here", style: TextStyle(fontSize: 18),),
            );
          }
        },
      ) 
    );
  }
}