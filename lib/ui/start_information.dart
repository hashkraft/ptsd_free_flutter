import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/models/settings.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';

// class StartInformation extends StatefulWidget {
//   const StartInformation({
//     super.key,
//   });

//   @override
//   State<StartInformation> createState() => _StartInformationState();
// }

// class _StartInformationState extends State<StartInformation> {
//   // @override
//   // void initState() {
//   //   SettingVariables().getPush().then((val) {
//   //     SettingVariables().push = val;
//   //     developer.log("Push: ${SettingVariables().push.toString()}");
//   //   });
//   //   SettingVariables().getRandomPTSD().then((val) {
//   //     SettingVariables().randomPTSD = val;
//   //     developer.log("Random PTSD: ${SettingVariables().randomPTSD.toString()}");
//   //   });

//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: CustomColoredText(
//           text: (SettingVariables().randomPTSD)
//               ? "Stress Stopper Breathwork"
//               : " 3 Keys to Live PTSD Free",
//           hexColor: "#FFFFFF",
//           size: 22,
//           weight: 400,
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         child: (SettingVariables().randomPTSD)
//             ? Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   CustomColoredText(
//                     text: "Take Action During Your Reaction",
//                     hexColor: "#F73C00",
//                     size: 18,
//                     weight: 500,
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           Image.asset(
//                             "assets/images/img_comfortable_eyes.png",
//                             width: 250,
//                           ),
//                           const SizedBox(height: 24),
//                           Image.asset(
//                             "assets/images/img_breathe_deep_2.png",
//                             width: 250,
//                           ),
//                           const SizedBox(height: 24),
//                           Image.asset(
//                             "assets/images/img_silent_okay_2.png",
//                             width: 250,
//                           ),
//                         ],
//                       ),
//                       Image.asset(
//                         "assets/images/breathwork_touch_heart.png",
//                         width: 100,
//                         height: 200,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   CustomColoredText(
//                     text: "REPEAT UNTIL YOUR STRESS IS GONE",
//                     hexColor: "#0057B8",
//                     size: 18,
//                     weight: 500,
//                   ),
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: CustomColoredText(
//                       text:
//                           "Stress Stopper Breathwork quickly activates your body's relaxation response",
//                       hexColor: "#2C3351",
//                       size: 16,
//                       weight: 500,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.resolveWith<Color?>(
//                             (Set<MaterialState> states) {
//                               return Colors.blue;
//                             },
//                           ),
//                         ),
//                         onPressed: () {
//                           context.go("/home");
//                         },
//                         child: CustomColoredText(
//                           text: "I'm Okay",
//                           hexColor: "#FFFFFF",
//                           size: 16,
//                           weight: 500,
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.resolveWith<Color?>(
//                             (Set<MaterialState> states) {
//                               return Colors.red;
//                             },
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: CustomColoredText(
//                           text: "Help me",
//                           hexColor: "#FFFFFF",
//                           size: 16,
//                           weight: 500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Image.asset(
//                     "assets/images/img_certified_american_institute.png",
//                     width: 280,
//                     height: 100,
//                   ),
//                 ],
//               )
//             : Container(
//                 padding: const EdgeInsets.all(16),
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 32),
//                         Row(
//                           children: [
//                             ImageIcon(
//                               const AssetImage(
//                                   "assets/images/stopper_inactive.png"),
//                               color: HexColor("#D12438"),
//                               size: 26,
//                             ),
//                             const SizedBox(
//                               width: 16,
//                             ),
//                             CustomColoredText(
//                               text: "1. Stopper Tab",
//                               hexColor: "#D12438",
//                               size: 16,
//                               weight: 500,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 16,
//                         ),
//                         CustomColoredText(
//                           text:
//                               "Will help you learn how to stop your stress reactions. Use it every time you become stressed.",
//                           hexColor: "#2C3351",
//                           size: 16,
//                           weight: 500,
//                         ),
//                         const SizedBox(height: 36),
//                         Row(
//                           children: [
//                             ImageIcon(
//                               const AssetImage(
//                                   "assets/images/resolve_inactive.png"),
//                               color: HexColor("#0B9F4F"),
//                               size: 26,
//                             ),
//                             const SizedBox(
//                               width: 16,
//                             ),
//                             CustomColoredText(
//                               text: "2. Resolve Tab",
//                               hexColor: "#0B9F4F",
//                               size: 16,
//                               weight: 500,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomColoredText(
//                           text:
//                               "Will help you heal the traumatic memories fueling your stress reactions. Use it weekly.",
//                           hexColor: "#2C3351",
//                           size: 16,
//                           weight: 500,
//                         ),
//                         const SizedBox(height: 36),
//                         Row(
//                           children: [
//                             ImageIcon(
//                               const AssetImage(
//                                   "assets/images/med_inactive.png"),
//                               color: HexColor("#036EB0"),
//                               size: 26,
//                             ),
//                             const SizedBox(
//                               width: 16,
//                             ),
//                             CustomColoredText(
//                               text: "3. My Meds",
//                               hexColor: "#036EB0",
//                               size: 16,
//                               weight: 500,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomColoredText(
//                           text:
//                               "Will help you structure a meditation practice. Meditate atleast once a day for 20 minutes.",
//                           hexColor: "#2C3351",
//                           size: 16,
//                           weight: 500,
//                         ),
//                         const SizedBox(height: 36),
//                       ],
//                     ),
//                     SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         child: ElevatedButton(
//                           style: ButtonStyle(backgroundColor:
//                               MaterialStateProperty.resolveWith<Color?>(
//                             (Set<MaterialState> states) {
//                               return Colors.red;
//                             },
//                           )),
//                           onPressed: () {
//                             context.go("/home");
//                           },
//                           child: const Text(
//                             "Go to Home Screen",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

class StartInfo1 extends StatefulWidget {
  const StartInfo1({super.key});

  @override
  State<StartInfo1> createState() => _StartInfo1State();
}

class _StartInfo1State extends State<StartInfo1> {
  final player = AudioPlayer();
  Future<void> playAudio() async {
    await player.play(AssetSource("iamokay.mp3"));
    player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> pauseAudio() async {
    await player.pause();
  }

  Future<void> stopAudio() async {
    await player.stop();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50), () {
      playAudio();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomColoredText(
          text: "Stress Stopper Breathwork",
          hexColor: "#FFFFFF",
          size: 22,
          weight: 400,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          child: Column(
        children: [
          const SizedBox(height: 16),
          CustomColoredText(
            text: "Take Action During Your Reaction",
            hexColor: "#F73C00",
            size: 18,
            weight: 500,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/img_comfortable_eyes.png",
                    width: 250,
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    "assets/images/img_breathe_deep_2.png",
                    width: 250,
                  ),
                  const SizedBox(height: 24),
                  Image.asset(
                    "assets/images/img_silent_okay_2.png",
                    width: 250,
                  ),
                ],
              ),
              Image.asset(
                "assets/images/breathwork_touch_heart.png",
                width: 100,
                height: 200,
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomColoredText(
            text: "REPEAT UNTIL YOUR STRESS IS GONE",
            hexColor: "#0057B8",
            size: 18,
            weight: 500,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomColoredText(
              text:
                  "Stress Stopper Breathwork quickly activates your body's relaxation response",
              hexColor: "#2C3351",
              size: 16,
              weight: 500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Colors.blue;
                    },
                  ),
                ),
                onPressed: () {
                  stopAudio().then((value) {
                    context.go("/startinfo2");
                  });
                },
                child: CustomColoredText(
                  text: "I'm Okay",
                  hexColor: "#FFFFFF",
                  size: 16,
                  weight: 500,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Colors.red;
                    },
                  ),
                ),
                onPressed: () {
                  stopAudio().then((value) {
                    context.go("/coaching");
                  });
                },
                child: CustomColoredText(
                  text: "Help me",
                  hexColor: "#FFFFFF",
                  size: 16,
                  weight: 500,
                ),
              ),
            ],
          ),
          Image.asset(
            "assets/images/img_certified_american_institute.png",
            width: 280,
            height: 100,
          ),
        ],
      )),
    );
  }
}

class StartInfo2 extends StatelessWidget {
  const StartInfo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomColoredText(
          text: " 3 Keys to Live PTSD Free",
          hexColor: "#FFFFFF",
          size: 22,
          weight: 400,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    ImageIcon(
                      const AssetImage("assets/images/stopper_inactive.png"),
                      color: HexColor("#D12438"),
                      size: 26,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomColoredText(
                      text: "1. Breathe Tab",
                      hexColor: "#D12438",
                      size: 16,
                      weight: 500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomColoredText(
                  text:
                      "Will help you learn how to stop your stress reactions. Use it every time you become stressed.",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 500,
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    ImageIcon(
                      const AssetImage("assets/images/resolve_inactive.png"),
                      color: HexColor("#0B9F4F"),
                      size: 26,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomColoredText(
                      text: "2. Heal Tab",
                      hexColor: "#0B9F4F",
                      size: 16,
                      weight: 500,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomColoredText(
                  text:
                      "Will help you heal the traumatic memories fueling your stress reactions. Use it weekly.",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 500,
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    ImageIcon(
                      const AssetImage("assets/images/med_inactive.png"),
                      color: HexColor("#036EB0"),
                      size: 26,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomColoredText(
                      text: "3. Meditate",
                      hexColor: "#036EB0",
                      size: 16,
                      weight: 500,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomColoredText(
                  text:
                      "Will help you structure a meditation practice. Meditate atleast once a day for 20 minutes.",
                  hexColor: "#2C3351",
                  size: 16,
                  weight: 500,
                ),
                const SizedBox(height: 36),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
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
                  child: const Text(
                    "Go to Home Screen",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
