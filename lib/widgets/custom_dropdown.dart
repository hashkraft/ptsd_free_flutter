import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: HexColor("#FCFCFC"),
        // border: Border.all(
        //   color: Colors.grey[300]!,
        //   style: BorderStyle.solid,
        //   width: 1,
        // ),
      ),
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: Container(),
        icon: const Icon(
          FeatherIcons.chevronDown,
          size: 16,
        ),
        isExpanded: true,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
            color: HexColor("#2C3351"),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        dropdownColor: Colors.grey.shade200,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: CustomText(text: item, weight: 400),
            ),
          );
        }).toList(),
      ),
    );
  }
}
