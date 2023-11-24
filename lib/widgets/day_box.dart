// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

import 'package:ptsd_free/widgets/custom_text.dart';

class DayBox extends StatefulWidget {
  final String text;
  Function whenTapped;
  DayBox({
    Key? key,
    required this.text,
    required this.whenTapped,
  }) : super(key: key);

  @override
  State<DayBox> createState() => _DayBoxState();
}

class _DayBoxState extends State<DayBox> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tapped = !tapped;
          widget.whenTapped(tapped);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: (tapped) ? HexColor("#0FA8ED") : Colors.white,
            border: Border.all(
                color: (tapped) ? HexColor("#0FA8ED") : HexColor("#C4C4C4"))),
        padding: const EdgeInsets.all(8),
        child: CustomColoredText(
            text: widget.text.substring(0, 2),
            weight: 400,
            size: 16,
            hexColor: (tapped) ? "#FFFFFF" : "#C4C4C4"),
      ),
    );
  }
}
