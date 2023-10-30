// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RadioItem extends StatefulWidget {
  final String value;
  late String groupValue;
  final String label;
  RadioItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
  });

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: widget.value,
          groupValue: widget.groupValue,
          activeColor: HexColor("#35518F"),
          onChanged: (val) {
            setState(() {
              widget.groupValue = val!;
            });
          },
        ),
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
