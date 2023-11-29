// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

class TimerScreen extends StatefulWidget {
  final int mins;
  final String sound;
  String imageText;
  String source;
  TimerScreen({
    super.key,
    required this.mins,
    required this.sound,
    this.imageText = "",
    this.source = "",
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // final int _duration = widget.mins * 60;
  final CountDownController _controller = CountDownController();
  bool paused = true;
  final player = AudioPlayer();
  late VideoPlayerController _videoController;

  Future<void> playAudio() async {
    switch (widget.sound) {
      case "Silence":
        break;
      case "I'm Okay":
        await player.play(AssetSource("iamokay.mp3"));
        player.setReleaseMode(ReleaseMode.loop);
        break;
      case "sound3":
        break;
      case "sound4":
        break;
      default:
        break;
    }

    // await player.play(AssetSource("iamokay.mp3"));
    // player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> pauseAudio() async {
    if (widget.sound != "Silence") {
      await player.pause();
    }
  }

  Future<void> stopAudio() async {
    if (widget.sound != "Silence") {
      await player.stop();
    }
  }

  @override
  void initState() {
    super.initState();

    paused = false;
    setState(() {
      _videoController =
          VideoPlayerController.asset("assets/images/med_vid_bg_3.mp4")
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

              _videoController.initialize();
              _videoController.play();
              _videoController.setLooping(true);
            });
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.start();
      playAudio();
      // _videoController.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Widget circularButton({required String title, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(HexColor("#64DEB0")),
          ),
          onPressed: onPressed,
          child: CustomText(text: title, weight: 500)),
    );
  }

  Widget bigButton() {
    return SizedBox(
      child: IconButton(
          onPressed: () {
            setState(() {
              paused = !paused;
              // if (_videoController.value.isPlaying) {
              //   _videoController.pause();
              // } else {
              //   _videoController.play();
              // }

              if (paused) {
                _controller.pause();

                pauseAudio();
              } else {
                developer.log("hit");
                _controller.resume();

                playAudio();
              }
            });
          },
          icon: Icon(
            (paused)
                ? Icons.play_circle_fill_outlined
                : Icons.pause_circle_filled_outlined,
            color: Colors.white,
            size: 100,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (paused) {
      _videoController.pause();
    } else {
      _videoController.play();
      _videoController.setLooping(true);
    }
    developer.log(_videoController.value.isPlaying.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go("/home", extra: 1);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: const Text("Prepare to meditate"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AspectRatio(
              // aspectRatio: _videoController.value.aspectRatio,
              aspectRatio: (MediaQuery.of(context).size.width) /
                  (MediaQuery.of(context).size.height),
              child: VideoPlayer(_videoController),
            ),
            Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomText(
                        text: "Total Meditation Time", weight: 500),
                    CustomColoredText(
                        text: "${widget.mins} mins",
                        hexColor: "#2C3351",
                        size: 26,
                        weight: 500),
                  ],
                ),
                Center(
                  child: CircularCountDownTimer(
                    duration: widget.mins * 60, // 10
                    initialDuration: 0,
                    controller: _controller,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2.5,
                    ringColor: Colors.white,
                    ringGradient: null,
                    fillColor: Colors.greenAccent,
                    fillGradient: null,
                    backgroundColor: HexColor("#40B7ED"),
                    backgroundGradient: null,
                    strokeWidth: 20.0,
                    strokeCap: StrokeCap.round,
                    textStyle: const TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textFormat: CountdownTextFormat.S,
                    isReverse: false,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: false,
                    onStart: () {
                      debugPrint('Countdown Started');
                    },
                    onComplete: () {
                      debugPrint('Countdown Ended');
                    },
                    onChange: (String timeStamp) {
                      debugPrint('Countdown Changed $timeStamp');
                    },
                    timeFormatterFunction:
                        (defaultFormatterFunction, duration) {
                      if (duration.inSeconds == 0) {
                        return "Start";
                      } else {
                        int totalDuration = widget.mins * 60;
                        int timeLeft = totalDuration - duration.inSeconds;
                        int minArm = (timeLeft / 60).floor();
                        int secArm = timeLeft % 60;
                        String minStr = "";
                        String secStr = "";
                        if (minArm < 10) {
                          minStr = "0$minArm";
                        } else {
                          minStr = minArm.toString();
                        }
                        if (secArm < 10) {
                          secStr = "0$secArm";
                        } else {
                          secStr = secArm.toString();
                        }
                        return "$minStr:$secStr";
                      }
                    },
                  ),
                ),
                bigButton(),
                const SizedBox(height: 10),
                circularButton(
                  title: "Done",
                  onPressed: () {
                    developer.log(
                        "Meditation sesson of ${widget.mins} mins completed!");
                    stopAudio();
                    if (widget.source == "resolve") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            currentIndex: 1,
                            extraInfo: 12,
                          ),
                        ),
                      );
                    } else if (widget.source == "step") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            currentIndex: 1,
                            extraInfo: 14,
                          ),
                        ),
                      );
                    } else {
                      context.go("/home", extra: 2);
                    }
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     circularButton(
                //       title: "Restart",
                //       onPressed: () =>
                //           _controller.restart(duration: widget.mins * 60),
                //     ),
                //     circularButton(
                //       title: "Done",
                //       onPressed: () {
                //         developer.log(
                //             "Meditation sesson of ${widget.mins} mins completed!");
                //         stopAudio();
                //         context.go("/aftermeditation");
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
