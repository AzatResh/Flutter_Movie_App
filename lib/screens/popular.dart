import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie/screens/movieDetails.dart';
import 'package:flutter_movie/url.dart';

class Popular extends StatefulWidget{
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => PopularState();
}

class PopularState extends State<Popular>{
  late List _topMovies = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  bool isSearching = false;

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }
  
  Future<void> loadMovies() async {
    final url = Uri.parse(getTopRated);
    final responce = await http.get(url);

    if(responce.statusCode == 200){
      final data = jsonDecode(responce.body);
      setState(() {
        _topMovies = data['results'];
      });
    } else{
      throw Exception('Failed to load movies.');
    }
  }

  Future<void> searchMovies(String movieName) async {
    if(movieName == '') {
      loadMovies();
      return;
    }

    final url = Uri.parse(getSearch(movieName));
    final responce = await http.get(url);

    if(responce.statusCode == 200){
      final data = jsonDecode(responce.body);
      setState(() {
        _topMovies = data['results'];
      });
    } else{
      throw Exception('Failed to load movies.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching? const Text("Popular movies"):
          TextField(
            controller: _searchController,
            focusNode: _searchFocus,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Color.fromARGB(137, 254, 254, 254)),
              border: InputBorder.none,
            ),
            onChanged: (String str){
              searchMovies(str);
            },
          ),
        centerTitle: true,
        actions: !isSearching? [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: (){
              setState(() {
                isSearching = true;
                _searchFocus.requestFocus();
              });
            }, 
          ),
        ]: 
        [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: (){
              setState(() {
                _searchFocus.unfocus();
              });
            }, 
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.xmark),
            onPressed: (){
              setState(() {
                isSearching = false;
                _searchController.text = '';
                loadMovies();
              });
            }, 
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _searchController.text == ''? 
            loadMovies: 
            searchMovies(_searchController.text);
          },
        child: GridView.builder(
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
                Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => MovieDetails(movie:_topMovies[index],)));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: _topMovies[index]['poster_path']!=null? NetworkImage('https://image.tmdb.org/t/p/w500' + _topMovies[index]['poster_path']): NetworkImage('https://image.tmdb.org/t/p/w500/4J1Vu6oGzt60fakP4delEPDqEhI.jpg'),
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}