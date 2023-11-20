// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/image_with_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';

class Resolve extends StatefulWidget {
  final Function(int) onValueChanged;
  int step;
  Resolve({
    Key? key,
    required this.onValueChanged,
    required this.step,
  }) : super(key: key);

  @override
  State<Resolve> createState() => _ResolveState();
}

class _ResolveState extends State<Resolve> {
  String trigger = "Places";
  List<String> triggerOptions = ["Places", "Sounds"];
  String emotion = "Anger";
  List<String> emotionsOptions = ["Anger", "Anxiety"];
  String feelWhere = "Head";
  String feelWhereNow = "Head";
  List<String> feelWhereOptions = ["Head", "Stomach"];
  String howOld = "Child";
  List<String> howOldOptions = ["Child", "Teen"];
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
                  text: "Resolve helps people::",
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
                    width: MediaQuery.of(context).size.width * 0.80,
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
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.2),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                hintText: "My thoughts here",
                obscureText: false,
              ),
            ],
          ),
          Column(
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.3),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.4),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 5) {
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
                    "Look back on your life, what is the first time you can remember feeling $emotion and thinking ${thoughtTrigger.text} at the same? Who was involved?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: whoWasInvolved,
                hintText: "Who was involved?",
                obscureText: false,
              ),
            ],
          ),
          Column(
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 6) {
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
                text: "Who or what triggered that prior stress reaction?",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: whoTriggered,
                hintText: "Who triggered?",
                obscureText: false,
              ),
            ],
          ),
          Column(
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.6),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 7) {
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
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.7),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 8) {
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
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.8),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 9) {
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
                text:
                    '''Use Stress Stopper Breathwork to release the emotion from the memory. Get comfortable, breathe deep and slow, and if possible, touch your head.''',
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 10) {
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
                text:
                    "Remember the stressful experience that happened when you were a $howOld",
                hexColor: "#2C3351",
                size: 16,
                weight: 400,
              ),
              const SizedBox(height: 16),
              ImageWText(
                  text: thoughtTrigger.text.isNotEmpty
                      ? "${thoughtTrigger.text.substring(0, 12)}..."
                      : "Bla bla"),
            ],
          ),
          Column(
            children: [
              // const LinearProgressIndicator(color: Colors.blue, value: 0.9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
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
    } else if (widget.step == 11) {
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
              // const LinearProgressIndicator(color: Colors.blue, value: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return Colors.green;
                        },
                      )),
                      onPressed: () {
                        setState(() {
                          widget.step = 0;
                          context.go("/timer");
                        });
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
    } else {
      return Container();
    }
  }
}
