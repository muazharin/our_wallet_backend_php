import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_wallet_mobile/theme.dart';

class TextInput extends StatelessWidget {
  TextInput({
    Key? key,
    @required this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.enabled,
    this.fillColor,
    this.borderColor,
    this.hintTextColor,
    this.borderRadius,
    this.keyboardType,
    this.onEditingComplete,
    this.onChange,
    this.onFocusChange,
    this.onTap,
    this.validator,
    this.controller,
  }) : super(key: key);
  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final bool? enabled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final BorderRadius? borderRadius;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Function(bool)? onFocusChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextFormField(
        enabled: enabled,
        onChanged: onChange,
        controller: controller,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        onTap: onTap,
        validator: validator,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        style: GoogleFonts.montserrat(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14.0,
            color: hintTextColor ?? Colors.black54,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          contentPadding: new EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey[350]!,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Color(0xff9093a6),
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
