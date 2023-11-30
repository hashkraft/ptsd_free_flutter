// import 'package:flutter/material.dart';

// class Breathe extends StatefulWidget {
//   const Breathe({super.key});

//   @override
//   State<Breathe> createState() => _BreathState();
// }

// class _BreathState extends State<Breathe> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Image.asset(
//             'assets/images/stopper_screen_head_bg.png',
//             fit: BoxFit.fitHeight,
//             // width: MediaQuery.of(context).size.width * 1,
//             height: MediaQuery.of(context).size.height * 0.2,
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.125,
//             right: MediaQuery.of(context).size.width / 2.5,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(),
//                 Image.asset(
//                   'assets/images/stress_top_icon_min.png',
//                   scale: 1.2,
//                   alignment: Alignment.center,
//                 ),
//                 const SizedBox(),
//               ],
//             ),
//           ),
//           ( currentStep >= 0 &&
//                   currentStep <= 3 &&
//                   routine)
//               ? Positioned(
//                   top: MediaQuery.of(context).size.height * 0.11,
//                   left: 20,
//                   child: CustomColoredText(
//                     text: (currentStep == 0)
//                         ? "Stop Routine PTSD"
//                         : (currentStep == 1)
//                             ? "Step 1"
//                             : (currentStep == 2)
//                                 ? "Step 2"
//                                 : (currentStep == 3)
//                                     ? "Finished"
//                                     : "",
//                     hexColor: "#FFFFFF",
//                     size: 22,
//                     weight: 700,
//                   ),
//                 )
//               : const SizedBox(),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: (random ||
//                     routine ||
//                     (widget.currentIndex == 1 && resolveStep > 0))
//                 ? AppBar(
//                     elevation: 0,
//                     automaticallyImplyLeading: (question) ? false : true,
//                     backgroundColor: Colors.transparent,
//                     leading: IconButton(
//                       onPressed: () {
//                         if (random) {
//                           setState(() {
//                             question = true;
//                             random = false;
//                             routine = false;
//                           });
//                         } else if (routine) {
//                           setState(() {
//                             if (currentStep > 0) {
//                               currentStep--;
//                             } else {
//                               question = true;
//                               random = false;
//                               routine = false;
//                             }
//                           });
//                         } else if ((widget.currentIndex == 1 &&
//                             resolveStep > 0)) {
//                           setState(() {
//                             if (resolveStep > 0) {
//                               resolveStep--;
//                             }
//                           });
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_back_ios,
//                           color: Colors.white, size: 22),
//                     ),
//                     title: CustomColoredText(
//                         text: appbarTitle,
//                         hexColor: "#FFFFFF",
//                         size: 22,
//                         weight: 400),
//                   )
//                 : (widget.currentIndex == 3 || widget.currentIndex == 4)
//                     ? AppBar(
//                         elevation: 0,
//                         automaticallyImplyLeading: false,
//                         // backgroundColor: HexColor("#23C4F1"),
//                         backgroundColor: Colors.transparent,
//                         title: CustomColoredText(
//                             text: appbarTitle,
//                             hexColor: "#FFFFFF",
//                             size: 22,
//                             weight: 400),
//                       )
//                     : (widget.currentIndex == 2 && myMedsInfo == false)
//                         ? AppBar(
//                             elevation: 0,
//                             leading: IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     myMedsInfo = true;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.arrow_back_ios_sharp,
//                                   color: Colors.white,
//                                 )),
//                             backgroundColor: Colors.transparent,
//                             title: CustomColoredText(
//                                 text: appbarTitle,
//                                 hexColor: "#FFFFFF",
//                                 size: 22,
//                                 weight: 400),
//                           )
//                         : AppBar(
//                             elevation: 0,
//                             automaticallyImplyLeading:
//                                 (question) ? false : true,
//                             backgroundColor: Colors.transparent,
//                             title: CustomColoredText(
//                                 text: appbarTitle,
//                                 hexColor: "#FFFFFF",
//                                 size: 22,
//                                 weight: 400),
//                           ),
//           )
//         ],
//       ),
//     );
//   }
// }
