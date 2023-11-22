// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

class ListTileMore extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  const ListTileMore({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.blue,
              ),
              const SizedBox(width: 10),
              CustomColoredText(
                text: text,
                size: 14,
                weight: 400,
                hexColor: "#2C3351",
              ),
            ],
          ),
          IconButton(
            onPressed: () => onPressed(),
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
            iconSize: 16.0,
          )
        ],
      ),
    );
  }
}
