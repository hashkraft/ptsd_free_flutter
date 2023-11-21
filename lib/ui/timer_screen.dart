// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class TimerScreen extends StatefulWidget {
  final int mins;
  const TimerScreen({
    super.key,
    required this.mins,
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
    await player.play(AssetSource("alarm.mp3"));
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

    paused = false;
    setState(() {
      _videoController =
          VideoPlayerController.asset("assets/images/med_vid_bg_3.mp4")
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {
                _videoController.play();
              });
            });
    });

    Future.delayed(const Duration(seconds: 1), () {
      _controller.start();
      playAudio();
    });
  }

  Widget circularButton({required String title, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 41, 161, 185)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
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
                _videoController.pause();
                pauseAudio();
              } else {
                _controller.resume();
                _videoController.play();
                playAudio();
              }
            });
          },
          icon: Icon(
            (paused)
                ? Icons.play_circle_fill_outlined
                : Icons.pause_circle_filled_outlined,
            color: Colors.black,
            size: 100,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    developer.log(_videoController.value.isPlaying.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prepare to meditate"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            Column(
              children: [
                Center(
                  child: CircularCountDownTimer(
                    duration: widget.mins * 60,
                    initialDuration: 0,
                    controller: _controller,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    ringColor: Colors.grey[300]!,
                    ringGradient: null,
                    fillColor: Colors.greenAccent,
                    fillGradient: null,
                    backgroundColor: Colors.green[500],
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
                      } else if (duration.inSeconds < 60) {
                        return Function.apply(
                            defaultFormatterFunction, [duration]);
                      } else {
                        String minutearm = (duration.inMinutes < 10)
                            ? "0${duration.inMinutes}"
                            : "${duration.inMinutes}";
                        int secondarmInt =
                            duration.inSeconds % (duration.inMinutes * 60);
                        String secondarm = (secondarmInt < 10)
                            ? "0$secondarmInt"
                            : "$secondarmInt";
                        return "$minutearm:$secondarm";
                        // return Function.apply(defaultFormatterFunction, [duration]);
                      }
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     circularButton(
                //       title: "Start",
                //       onPressed: () => _controller.start(),
                //     ),
                //     circularButton(
                //       title: "Pause",
                //       onPressed: () => _controller.pause(),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // circularButton(
                //   title: "Resume",
                //   onPressed: () => _controller.resume(),
                // ),
                bigButton(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    circularButton(
                      title: "Restart",
                      onPressed: () =>
                          _controller.restart(duration: widget.mins * 60),
                    ),
                    circularButton(
                      title: "Done!",
                      onPressed: () {
                        developer.log(
                            "Meditation sesson of ${widget.mins} mins completed!");
                        stopAudio();
                        context.go("/aftermeditation");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
