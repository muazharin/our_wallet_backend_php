import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextRegular extends StatelessWidget {
  const TextRegular({
    Key? key,
    @required this.text,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.size,
    this.textDecoration,
  }) : super(key: key);
  final String? text;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? size;
  final TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        color: color ?? Colors.black,
        fontSize: size ?? 12.0,
        decoration: textDecoration,
      ),
    );
  }
}

class TextBold extends StatelessWidget {
  const TextBold({
    Key? key,
    @required this.text,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.size,
    this.textDecoration,
  }) : super(key: key);
  final String? text;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? size;
  final TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        color: color ?? Colors.black,
        fontSize: size ?? 12.0,
        decoration: textDecoration,
      ),
    );
  }
}
