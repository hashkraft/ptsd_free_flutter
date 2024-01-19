import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/ui/home_screen.dart';
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
    final Uri url =
        Uri.parse('https://www.facebook.com/groups/144778457510146');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchYoutubeUrl() async {
    final Uri url =
        Uri.parse('https://www.youtube.com/@stressisgone1537/playlists');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInstagramUrl() async {
    final Uri url = Uri.parse('https://www.instagram.com/stressisgone/reels/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchLinkedInUrl() async {
    final Uri url =
        Uri.parse('https://www.linkedin.com/in/brett-cotter-6513693/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canpop) {
        // context.go("/home", extra: 4);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(currentIndex: 4)));
      },
      child: Scaffold(
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
                    // context.go("/home", extra: 4);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(currentIndex: 4)));
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
                          "assets/images/facebook_new.png",
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _launchYoutubeUrl,
                        child: Image.asset(
                          "assets/images/youtube.png",
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _launchInstagramUrl,
                        child: Image.asset(
                          "assets/images/instagram.png",
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _launchLinkedInUrl,
                        child: Image.asset(
                          "assets/images/linkedin.png",
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
      ),
    );
  }
}
