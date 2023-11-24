import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#23C4F1"),
        leading: IconButton(
            onPressed: () {
              context.go("/home", extra: 3);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.white,
            )),
        title: CustomColoredText(
            text: "Privacy Policy", hexColor: "#FFFFFF", size: 22, weight: 500),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CustomColoredText(
                text:
                    "THIS IS A LEGAL AGREEMENT BETWEEN YOU AND STRESS IS GONE, INC. THESE TERMS GOVERN YOUR USE OF ANY AND ALL OF STRESS IS GONE PRODUCTS AND/OR SERVICES. TO AGREE TO THESE TERMS, CLICK \"I AGREE.\" IF YOU DO NOT AGREE TO THESE TERMS, DO NOT CLICK \"I AGREE,\" AND DO NOT USE THE PRODUCTS AND SERVICES PROVIDED. YOU MUST ACCEPT AND ABIDE BY THESE TERMS AS PRESENTED TO YOU: CHANGES, ADDITIONS, OR DELETIONS ARE NOT ACCEPTABLE, AND STRESS IS GONE REFUSES YOUR ACCESS TO ANY AND ALL PRODUCTS AND SERVICES FOR NONCOMPLIANCE WITH ANY PART OF THIS AGREEMENT.",
                hexColor: "#2C3351",
                size: 14,
                weight: 400,
              ),
              const SizedBox(height: 8),
              CustomColoredText(
                text:
                    "Definition of Stress Is Gone Products and Services: Stress Is Gone, Inc. provides the products and services offered on the Stress Is Gone website. Products include anything downloaded from our website, and/or viewed and/or heard on our website. Services include any and all types of stress elimination sessions (including Corporate, Academic, Public, Private, Individual, Phone, etc.), workshops, events, tele-classes and mentoring programs. You fully and completely understand the Stress Is Gone Products and/or Services are not a replacement or substitute for any type of therapy and/or prescription drugs. You fully and completely understand the Stress Is Gone Products and/or Services are coaching exercises that may or may not result in alleviating your stress. You agree that Stress Is Gone has no liability regarding your experience with the Stress Is Gone Products and/or Services in any way.",
                hexColor: "#2C3351",
                size: 14,
                weight: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
