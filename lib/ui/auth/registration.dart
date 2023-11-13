import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ptsd_free/utils/functions.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/text_form_field.dart';
import 'dart:developer' as developer;

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  Future<void> createAccount() async {
    String deviceId = (await getId()) ?? "";
    developer.log(deviceId);
    if (usernameController.text.isEmpty || zipcodeController.text.isEmpty) {
      developer.log("Enter all fields");
    } else if (deviceId.isNotEmpty) {
    } else {
      developer.log("Device ID cannot be found");
    }
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: deviceId,
      );
      developer.log("User Created!");
    } on FirebaseAuthException catch (ex) {
      developer.log(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomColoredText(
                text: "Username: ",
                hexColor: "#2C3351",
                size: 16,
                weight: 500,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomColoredText(
                text: "Zip Code: ",
                hexColor: "#2C3351",
                size: 16,
                weight: 500,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: zipcodeController,
                hintText: "Zip Code",
                obscureText: false,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    onPressed: () async {
                      developer.log(usernameController.text);
                      developer.log(zipcodeController.text);
                      await createAccount();
                      usernameController.clear();
                      zipcodeController.clear();
                    },
                    child: const Text("Submit"),
                  ),
                  const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
