// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

class ListTileSettings extends StatelessWidget {
  final String text;
  final Function onPressed;
  const ListTileSettings({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomColoredText(
            text: text,
            size: 14,
            weight: 400,
            hexColor: "#2C3351",
          ),
          IconButton(
            onPressed: () => onPressed(),
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 16.0,
          )
        ],
      ),
    );
  }
}
