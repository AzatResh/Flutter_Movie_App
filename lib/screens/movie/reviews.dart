import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget{
  final int movieId;

  const Reviews({super.key, required this.movieId});
  @override
  State<Reviews> createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.movieId.toString()),
    );
  }
}
