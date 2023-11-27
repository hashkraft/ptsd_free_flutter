import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';
import 'package:ptsd_free/widgets/image_with_text.dart';

class AfterMeditation extends StatefulWidget {
  String imageText;
  AfterMeditation({super.key, this.imageText = ""});

  @override
  State<AfterMeditation> createState() => _AfterMeditationState();
}

class _AfterMeditationState extends State<AfterMeditation> {
  int screen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/resolve_header_bg.png',
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: (screen == 1)
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    // leading: IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.arrow_back_ios_new_sharp,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    title: CustomColoredText(
                        text: "Great Job",
                        hexColor: "#FFFFFF",
                        size: 22,
                        weight: 400),
                  )
                : (screen == 2)
                    ? AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              screen -= 1;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_sharp,
                            color: Colors.white,
                          ),
                        ),
                        title: CustomColoredText(
                            text: "Meditate",
                            hexColor: "#FFFFFF",
                            size: 22,
                            weight: 400),
                      )
                    : AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              screen -= 1;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_sharp,
                            color: Colors.white,
                          ),
                        ),
                        title: CustomColoredText(
                            text: "You did it!",
                            hexColor: "#FFFFFF",
                            size: 22,
                            weight: 400),
                      ),
            body: Padding(
              padding: EdgeInsets.only(
                  top: (screen == 3) ? 100 : 70, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomColoredText(
                        text: (screen == 1)
                            ? '''Great job! Now use Stress Stopper Breathwork to reduce present day stress. Think about a recent reaction triggered by places.'''
                            : (screen == 2)
                                ? '''Imagine yourself inside the recent memory, breathing deep and slow, silently saying, \"I\'m okay\" once per breath. Press Start Meditation.'''
                                : '''Congratulations!\n
You faced your stress head on with PTSD Free. For further assistance, touch the More tab at the bottom right hand side of your screen. Great job!''',
                        hexColor: "#2C3351",
                        size: 18,
                        weight: 500,
                      ),
                      const SizedBox(height: 30),
                      (screen == 3)
                          ? Image.asset(
                              "assets/images/smile_ill.png",
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.3,
                            )
                          : (screen == 2)
                              ? Image.asset(
                                  "assets/images/two_users_okay.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                )
                              : ImageWText(
                                  text: widget.imageText.isEmpty
                                      ? "I feel better"
                                      : widget.imageText),
                    ],
                  ),
                  Column(
                    children: [
                      (screen == 2)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      return HexColor("#308B06");
                                    }),
                                  ),
                                  onPressed: () {
                                    context
                                        .go("/timer", extra: [10, "I'm Okay"]);
                                  },
                                  child: CustomColoredText(
                                      text: "Start Meditation",
                                      hexColor: "#FFFFFF",
                                      size: 18,
                                      weight: 400),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      screen += 1;
                                    });
                                  },
                                  child: CustomColoredText(
                                      text: "Continue",
                                      hexColor: "#308B06",
                                      size: 18,
                                      weight: 400),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor:
                                        MaterialStateProperty.resolveWith<
                                            Color?>(
                                      (Set<MaterialState> states) {
                                        return Colors.red;
                                      },
                                    )),
                                    onPressed: () {
                                      if (screen == 1 || screen == 2) {
                                        setState(() {
                                          screen += 1;
                                        });
                                      }

                                      if (screen == 3) {
                                        context.go("/home", extra: 1);
                                      }
                                    },
                                    child: CustomColoredText(
                                      text: "Continue",
                                      hexColor: "#FFFFFF",
                                      size: 16,
                                      weight: 500,
                                    ),
                                  ),
                                ),
                                const SizedBox(),
                              ],
                            ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
