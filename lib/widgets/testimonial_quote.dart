// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ptsd_free/widgets/custom_colored_text.dart';

class TestimonialQuote extends StatelessWidget {
  final String quote;
  final String name;
  // final String desig1;
  // final String desig2;
  const TestimonialQuote({
    super.key,
    required this.quote,
    required this.name,
    // required this.desig1,
    // required this.desig2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomColoredText(
          text: "\"$quote\"",
          hexColor: "#75797C",
          size: 16,
          weight: 400,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      color: HexColor("#23C4F1"),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
                // CustomColoredText(
                //     text: name, hexColor: "#23C4F1", size: 16, weight: 500),

                // CustomColoredText(
                //     text: desig1, hexColor: "#23C4F1", size: 16, weight: 500),
                // CustomColoredText(
                //     text: desig2, hexColor: "#23C4F1", size: 16, weight: 500),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
