import 'package:flutter/material.dart';

class ImageWText extends StatelessWidget {
  final String text;
  const ImageWText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          children: [
            Positioned(
              // top: 0,
              // right: 50,
              child: Image.asset(
                "assets/images/two_users.png",
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
