import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

class AfterMeditation extends StatelessWidget {
  const AfterMeditation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/stopper_screen_head_bg.png',
          ),
          Positioned(
            top: 80,
            right: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Image.asset(
                  'assets/images/stress_top_icon_min.png',
                  scale: 1.2,
                  alignment: Alignment.center,
                ),
                const SizedBox(),
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: const Text(
                "Congratulations",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 100, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomColoredText(
                        text: '''Congratulations!\n
You faced your stress head on with PTSD Free. For further assistance, touch the More tab at the bottom right hand side of your screen. Great job!''',
                        hexColor: "#2C3351",
                        size: 14,
                        weight: 400,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        "assets/images/smile_ill.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  return Colors.red;
                                },
                              )),
                              onPressed: () {
                                context.go("/home");
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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