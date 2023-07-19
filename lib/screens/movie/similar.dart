import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Similar extends StatefulWidget{
  final int movieId;

  const Similar({super.key, required this.movieId});
  @override
  State<Similar> createState() => SimilarState();
}

class SimilarState extends State<Similar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.movieId.toString()),
    );
  }
}
