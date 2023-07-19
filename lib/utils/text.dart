import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedText extends StatelessWidget{
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const ModifiedText({
    super.key, 
    required this.text, 
    this.color = Colors.white, 
    required this.size, 
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.clip,
    });

  @override
  Widget build(BuildContext context) {
    return(
      Text(text, style: GoogleFonts.roboto(color: color, fontSize: size, fontWeight: fontWeight,), textAlign: textAlign, overflow: overflow,)
    );
  }
}