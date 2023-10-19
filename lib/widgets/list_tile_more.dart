// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Text(text),
                ],
              ),
              IconButton(
                onPressed: () => onPressed(),
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 16.0,
              )
            ],
          ),
          Divider(
            color: HexColor("#A9A9A9"),
            thickness: 0.7,
          )
        ],
      ),
    );
  }
}
