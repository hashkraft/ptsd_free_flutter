// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ptsd_free/widgets/custom_dropdown.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';

class Resolve extends StatefulWidget {
  int step;
  Resolve({
    super.key,
    required this.step,
  });

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
  // String trigger2;
  // String trigger3;
  @override
  Widget build(BuildContext context) {
    if (widget.step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("CONTENT FOR RESOLVE"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    widget.step--;
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              const Text("Step 1"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              Text("Step2: bla bla $trigger"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              Text("Step3: bla bla $trigger"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 4) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              Text("Step 4: bla bla ${thoughtTrigger.text}"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              Text("Step 5: bla bla ${thoughtTrigger.text} $feelWhere"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 6) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              Text("Step 6: bla bla ${thoughtTrigger.text} $trigger"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 7) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              const Text("How old were you then?"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 8) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              const Text("Where do you feel tension right now?"),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 9) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              const Text("Static Text step 9"),
            ],
          ),
          Column(
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 0.9),
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
                        setState(() {
                          widget.step++;
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
    } else if (widget.step == 10) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.step--;
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 16),
                      Text("Previous step")
                    ],
                  )),
              const Text("Static Text step 10"),
            ],
          ),
          Column(
            children: [
              const LinearProgressIndicator(color: Colors.blue, value: 1),
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
                        setState(() {
                          widget.step = 0;
                          context.go("/timer");
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
    } else {
      return Container();
    }
  }
}
