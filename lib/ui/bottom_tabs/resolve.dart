// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/ui/timer_screen.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/image_with_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';

class Resolve extends StatefulWidget {
  final Function(int) onValueChanged;
  int step;
  String imgText = "";
  Resolve({
    super.key,
    required this.onValueChanged,
    required this.step,
    this.imgText = "",
  });

  @override
  State<Resolve> createState() => _ResolveState();
}

class _ResolveState extends State<Resolve> {
  String trigger = "Places";
  List<String> triggerOptions = [
    "Places",
    "Sounds",
    "Smell",
    "People",
    "Family",
    "Siblings",
    "Your Parents",
    "Your Spouse",
    "Your Relationship",
    "Children",
    "Work",
    "Your Boss",
    "Co-workers",
    "Strangers",
    "Neighbours",
    "Worries",
    "Recurring Memories",
    "Your Commute",
    "School",
    "Teachers",
    "Peers",
    "Finances",
    "Situations",
    "Waiting In Line",
    "Personal Health Issues",
    "Authority Figures",
    "Others"
  ];
  String emotion = "Anger";
  List<String> emotionsOptions = [
    "Anger",
    "Frustrated",
    "Confused",
    "Hatred",
    "Rage",
    "Irritable",
    "Guilt",
    "Shame",
    "Mistrust",
    "Betrayal",
    "Depressed",
    "Sad",
    "Hopeless",
    "Overwhelmed",
    "Lonely",
    "Alienated",
    "Jealous",
    "Anxiety",
    "Panic",
    "Others"
  ];
  String feelWhere = "Head";
  String feelWhereNow = "Head";
  List<String> feelWhereOptions = [
    "Head",
    "Neck",
    "Throat",
    "Shoulders",
    "Chest",
    "Stomach",
    "Solar Plexus",
    "Back",
    "Waist",
    "Hips",
    "Lower Body"
  ];

  String howOld = "A Child";
  List<String> howOldOptions = [
    "A Child",
    "A Teenager",
    "In your 20s",
    "In your 30s",
    "In your 40s",
    "In your 50s",
    "60+"
  ];
  TextEditingController thoughtTrigger = TextEditingController();
  TextEditingController whoWasInvolved = TextEditingController();
  TextEditingController whoTriggered = TextEditingController();
  String title = "";

  void changeTitle({required String title}) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    developer.log(widget.step.toString());
    if (widget.step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomColoredText(
                  text: "Heal helps people:",
                  hexColor: "#00B803",
                  size: 18,
                  weight: 400),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomColoredText(
                      text: "Identify the memories that fuels stress",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomColoredText(
                      text: "Heal trauma within those memories",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomColoredText(
                      text: "Reduce the intensity of the reaction",
                      hexColor: "#000000",
                      size: 16,
                      weight: 400),
                ],
              ),
              const SizedBox(height: 15),
              CustomColoredText(
                  text:
                      "This tab includes an assessment, as well as two tailored meditations.",
                  hexColor: "#000000",
                  size: 16,
                  weight: 400),
              CustomColoredText(
                  text:
                      "Use it once a week until your stress reactions have diminished.",
                  hexColor: "#000000",
                  size: 16,
                  weight: 400),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.red;
                        },
                      )),
                      onPressed: () async {
                        // await setPincodeRange(10399, 10409, "3477673889");
                        widget.step += 1;
                        widget.onValueChanged(widget.step);

                        // setState(() {
                        //   widget.step++;
                        // });
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextButton(
              //   onPressed: () {
              //     // widget.step--;
              //     widget.step -= 1;
              //     widget.onValueChanged(widget.step);
              //   },
              //   child: const Row(
              //     children: [
              //       Icon(Icons.arrow_back_ios, size: 16),
              //       Text("Previous step")
              //     ],
              //   ),
              // ),
              // CustomColoredText(
              //   text: "Step ${widget.step}",
              //   hexColor: "#0F6ED8",
              //   size: 20,
              //   weight: 400,
              // ),
              // const SizedBox(height: 16),
              CustomColoredText(
                text: "What triggers your most intense stress reactions?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                  items: triggerOptions,
                  value: trigger,
                  onChanged: (val) {
                    setState(() {
                      trigger = val!;
                    });
                  }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "10% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                        // setState(() {
                        //   widget.step++;
                        // });
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextButton(
              //   onPressed: () {
              //     widget.step -= 1;
              //     widget.onValueChanged(widget.step);
              //     // setState(() {
              //     //   widget.step--;
              //     // });
              //   },
              //   child: const Row(
              //     children: [
              //       Icon(Icons.arrow_back_ios, size: 16),
              //       Text("Previous step")
              //     ],
              //   ),
              // ),
              // CustomColoredText(
              //   text: "Step ${widget.step}",
              //   hexColor: "#0F6ED8",
              //   size: 20,
              //   weight: 400,
              // ),
              // const SizedBox(height: 16),
              CustomColoredText(
                text: "Which emotion fuels this stress triggered by $trigger ?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                items: emotionsOptions,
                value: emotion,
                onChanged: (val) {
                  setState(() {
                    emotion = val!;
                  });
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "20% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.2),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        // updateValue(widget.step++);
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                        // setState(() {
                        //   widget.step++;
                        // });
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextButton(
              //     onPressed: () {
              //       // updateValue(widget.step--);
              //       widget.step -= 1;
              //       widget.onValueChanged(widget.step);
              //       // setState(() {
              //       //   widget.step--;
              //       // });
              //     },
              //     child: const Row(
              //       children: [
              //         Icon(Icons.arrow_back_ios, size: 16),
              //         Text("Previous step")
              //       ],
              //     )),
              // CustomColoredText(
              //   text: "Step ${widget.step}",
              //   hexColor: "#0F6ED8",
              //   size: 20,
              //   weight: 400,
              // ),
              // const SizedBox(height: 16),
              CustomColoredText(
                text:
                    "When $trigger triggers your stress reactions, what thought repeats in the back of your mind?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: thoughtTrigger,
                hintText: "I have to get out of here",
                obscureText: false,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "30% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.3),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        // updateValue(widget.step++);
                        if (thoughtTrigger.text.isEmpty) {
                          showSnackbar(context, "Please fill required fields");
                        } else {
                          widget.step += 1;
                          widget.onValueChanged(widget.step);
                        }

                        // setState(() {
                        //   widget.step++;
                        // });
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextButton(
              //   onPressed: () {
              //     // updateValue(widget.step--);
              //     widget.step -= 1;
              //     widget.onValueChanged(widget.step);
              //     // setState(() {
              //     //   widget.step--;
              //     // });
              //   },
              //   child: const Row(
              //     children: [
              //       Icon(Icons.arrow_back_ios, size: 16),
              //       Text("Previous step")
              //     ],
              //   ),
              // ),
              // CustomColoredText(
              //   text: "Step ${widget.step}",
              //   hexColor: "#0F6ED8",
              //   size: 20,
              //   weight: 400,
              // ),
              // const SizedBox(height: 16),
              CustomColoredText(
                text:
                    "While thinking of ${thoughtTrigger.text} where do you feel the tension?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                items: feelWhereOptions,
                value: feelWhere,
                onChanged: (val) {
                  setState(() {
                    feelWhere = val!;
                  });
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "40% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.4),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    "Look back on your life, what is the first time you can remember feeling $emotion and thinking ${thoughtTrigger.text} at the same? Who was involved?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: whoWasInvolved,
                hintText: "Please write openly",
                obscureText: false,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "50% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        if (whoWasInvolved.text.isEmpty) {
                          showSnackbar(context, "Please fill required fields");
                        } else {
                          widget.step += 1;
                          widget.onValueChanged(widget.step);
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 6) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "Who or what triggered that prior stress reaction?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: whoTriggered,
                hintText: "My Father, A Violent Crime, etc.",
                obscureText: false,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "60% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.6),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        if (whoTriggered.text.isEmpty) {
                          showSnackbar(context, "Please fill required fields");
                        } else {
                          widget.step += 1;
                          widget.onValueChanged(widget.step);
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 7) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "Approximately how old were you?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                items: howOldOptions,
                value: howOld,
                onChanged: (val) {
                  setState(() {
                    howOld = val!;
                  });
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "70% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.7),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 8) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "Where do you feel tension right now?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                items: feelWhereOptions,
                value: feelWhereNow,
                onChanged: (val) {
                  setState(() {
                    feelWhereNow = val!;
                  });
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "80% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.8),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 9) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    '''Use Stress Stopper Breathwork to release the emotion from the memory. Get comfortable, breathe deep and slow, and if possible, touch your $feelWhereNow.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset("assets/images/stress_stopper_breath.png",
                    width: MediaQuery.of(context).size.width * 0.60),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                  text: "90% Completed",
                  hexColor: "#056AD6",
                  size: 16,
                  weight: 400),
              const SizedBox(height: 10),
              const LinearProgressIndicator(color: Colors.blue, value: 0.9),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 10) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    "Remember the stressful experience that happened when you were a $howOld",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              ImageWText(
                  text: thoughtTrigger.text.isNotEmpty
                      ? (thoughtTrigger.text.length > 12)
                          ? "${thoughtTrigger.text.substring(0, 12)}..."
                          : thoughtTrigger.text
                      : "..."),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
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
                        setState(() {
                          widget.step += 1;
                          widget.onValueChanged(widget.step);
                        });
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 11) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    '''Imagine yourself inside the recent memory, breathing deep and slow, silently saying "I'm Okay" once per breath. Press continue to start Meditation.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  "assets/images/two_users_okay.png",
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.green;
                        },
                      )),
                      onPressed: () {
                        // setState(() {
                        //   widget.step += 1;
                        //   widget.onValueChanged(widget.step);
                        // });
                        // context.go("/timer", extra: [10, "I'm Okay"]);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TimerScreen(
                              mins: 10,
                              sound: "I'm Okay",
                              source: "resolve",
                              imageText: thoughtTrigger.text,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Start Meditation",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
      );
    } else if (widget.step == 12) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    '''Great job! Now use Stress Stopper Breathwork to reduce present day stress. Think about a recent reaction triggered by ${thoughtTrigger.text}.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 500,
              ),
              const SizedBox(height: 30),
              Center(
                child: ImageWText(
                    text: widget.imgText.isNotEmpty
                        ? (widget.imgText.length > 12)
                            ? "${widget.imgText.substring(0, 12)}..."
                            : widget.imgText
                        : "..."),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.red;
                        },
                      )),
                      onPressed: () {
                        setState(() {
                          widget.step += 1;
                          widget.onValueChanged(widget.step);
                        });
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
      );
    } else if (widget.step == 13) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text:
                    '''Imagine yourself inside the recent memory, breathing deep and slow, silently saying, \"I\'m okay\" once per breath. Press Start Meditation.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 500,
              ),
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/two_users_okay.png",
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                        return HexColor("#308B06");
                      }),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(
                            mins: 10,
                            sound: "I'm Okay",
                            source: "step",
                          ),
                        ),
                      );
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
                        widget.step += 1;
                        widget.onValueChanged(widget.step);
                      });
                    },
                    child: CustomColoredText(
                        text: "Continue",
                        hexColor: "#308B06",
                        size: 18,
                        weight: 400),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      );
    } else if (widget.step == 14) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CustomColoredText(
                      text: "Congratulations!",
                      hexColor: "#0E9E50",
                      size: 20,
                      weight: 500),
                  const SizedBox(height: 15)
                ],
              ),
              CustomColoredText(
                text: '''
You faced your stress head on with PTSD Free. For further assistance, touch the More tab at the bottom right hand side of your screen. Great job!''',
                hexColor: "#2C3351",
                size: 16,
                weight: 500,
              ),
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/smile_ill.png",
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.red;
                        },
                      )),
                      onPressed: () {
                        setState(() {
                          widget.step = 0;
                          widget.onValueChanged(widget.step);
                        });
                      },
                      child: CustomColoredText(
                        text: "Start Over",
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
      );
    } else {
      return Container();
    }
  }
}
