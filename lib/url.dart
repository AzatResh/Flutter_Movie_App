import 'package:flutter_movie/api_key.dart';


final getTrending = 'https://api.themoviedb.org/3/trending/all/day?language=ru&api_key='+tmdbApiKey;
final getNowPlaying = 'https://api.themoviedb.org/3/movie/now_playing?language=ru&api_key='+tmdbApiKey;
final getUpcoming = 'https://api.themoviedb.org/3/movie/upcoming?language=ru&api_key='+tmdbApiKey;
final getTopRated = 'https://api.themoviedb.org/3/movie/top_rated?language=ru&api_key='+tmdbApiKey;

String getSimilar(int movie_id){
  return 'https://api.themoviedb.org/3/movie/${movie_id}/similar?language=ru&api_key='+tmdbApiKey;
}
String getCredits(int movie_id){
  return 'https://api.themoviedb.org/3/movie/${movie_id}/credits?language=ru&api_key='+tmdbApiKey;
}
String getReviews(int movie_id){
  return 'https://api.themoviedb.org/3/movie/${movie_id}/reviews?api_key='+tmdbApiKey;
}
String getTrailer(int movie_id){
  return 'https://api.themoviedb.org/3/movie/${movie_id}/videos?language=en&api_key='+tmdbApiKey;
}
String getSearch(String movieName){
  return 'https://api.themoviedb.org/3/search/movie?query=${movieName}&language=en&api_key='+tmdbApiKey;
}