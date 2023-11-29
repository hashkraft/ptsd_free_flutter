import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Membership extends StatelessWidget {
  const Membership({super.key});

  Future<void> _launchMemberUrl() async {
    final Uri url = Uri.parse('https://www.stressisgone.com/membership');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchFacebookUrl() async {
    final Uri url = Uri.parse('https://www.facebook.com/StressIsGone');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchXUrl() async {
    final Uri url = Uri.parse('https://x.com/stressisgone');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/membership_login.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  context.go("/home", extra: 4);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                ),
              ),
              title: CustomColoredText(
                text: "Membership",
                hexColor: "#FFFFFF",
                size: 22,
                weight: 400,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Logo.png",
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _launchMemberUrl,
                      child: Image.asset(
                        "assets/images/Membership@1x.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: _launchFacebookUrl,
                      child: Image.asset(
                        "assets/images/facebook.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _launchXUrl,
                      child: Image.asset(
                        "assets/images/twitter.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
