// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int weight;
  const CustomText({
    super.key,
    required this.text,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          color: HexColor("#2C3351"),
          fontSize: 16,
          fontWeight: (weight == 500)
              ? FontWeight.w500
              : (weight == 400)
                  ? FontWeight.w400
                  : FontWeight.w300,
        ),
      ),
    );
    ;
  }
}
