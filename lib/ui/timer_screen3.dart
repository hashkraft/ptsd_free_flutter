// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/ui/start_information.dart';
import 'package:video_player/video_player.dart';

import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

class TimerScreen3 extends StatefulWidget {
  const TimerScreen3({super.key});

  @override
  State<TimerScreen3> createState() => _TimerScreen3State();
}

class _TimerScreen3State extends State<TimerScreen3>
    with WidgetsBindingObserver {
  final int _duration = 10 * 60;
  final CountDownController _controller = CountDownController();
  bool paused = true;
  final player = AudioPlayer();
  late VideoPlayerController _videoController;

  Future<void> playChime() async {
    await player.play(AssetSource("chime2.mp3"), volume: 0.5);
    Future.delayed(const Duration(seconds: 5), () {
      player.stop();
    });
  }

  bool _isCurrentRoute() {
    return ModalRoute.of(context)?.isCurrent == true;
  }

  Future<void> playAudio() async {
    await player.play(AssetSource("heal2.mp3"), volume: 1);
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
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    paused = false;
    setState(() {
      _videoController =
          VideoPlayerController.asset("assets/images/med_vid_bg_3.mp4")
            ..initialize().then((_) {
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

  void startFadeOut() async {
    const fadeDuration = Duration(seconds: 10);
    const fadeSteps = 100;

    double initialVolume = player.volume;

    for (int i = 0; i < fadeSteps; i++) {
      double newVolume = initialVolume * (1 - i / fadeSteps);
      await player.setVolume(newVolume);
      await Future.delayed(fadeDuration ~/ fadeSteps);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("&1");
    if (state == AppLifecycleState.paused && _isCurrentRoute()) {
      _controller.pause();
      _videoController.pause();
      player.stop();
    }
    // if (state == AppLifecycleState.resumed && _isCurrentRoute()) {
    //   _controller.resume();
    //   player.resume();
    //   _videoController.play();
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
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

            if (paused) {
              _controller.pause();

              pauseAudio();
            } else {
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
        ),
      ),
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
    dynamic args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return PopScope(
      canPop: false,
      onPopInvoked: (canpop) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(currentIndex: 0)));
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                stopAudio();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      currentIndex: 0,
                    ),
                  ),
                );
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
                          text: "10 mins",
                          hexColor: "#2C3351",
                          size: 26,
                          weight: 500),
                    ],
                  ),
                  Center(
                    child: CircularCountDownTimer(
                      duration: _duration,
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
                        log('Countdown Started');
                      },
                      onComplete: () {
                        stopAudio();
                        log('Countdown Ended');
                        Timer(const Duration(seconds: 3), () {
                          playChime().then((value) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  currentIndex: 1,
                                  extraInfo: 14,
                                ),
                              ),
                            );
                          });
                        });
                      },
                      onChange: (String timeStamp) {
                        log('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "Start";
                        } else {
                          int totalDuration = _duration;
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
                          if (timeLeft == 10) {
                            startFadeOut();
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
                      log("Meditation sesson of 10 mins completed!");
                      stopAudio();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            currentIndex: 1,
                            extraInfo: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
