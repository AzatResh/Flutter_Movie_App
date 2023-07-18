import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int value;

  const StarRating({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return(
      Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index){
          return Icon(
            index < value ? Icons.star : Icons.star_border,
            color: Color.fromARGB(255, 255, 215, 15),
            size: 20,
          );
        })
      )
    );
  }
}