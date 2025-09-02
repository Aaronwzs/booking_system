import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class footerform extends StatelessWidget {
  const footerform({
    super.key,
    required this.image,
    required this.buttonText,
    required this.alternativeText,
    required this.alternativeTextSpan,
    this.heightBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onPressGoogle,
    this.onPressAlternative,
  });

  //Variables -- Declared in Constructor

  final String image, buttonText, alternativeText, alternativeTextSpan;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget Function()? onPressGoogle, onPressAlternative;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        const Text("OR"),
        SizedBox(height: heightBetween),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: Image(image: AssetImage(image), width: 25.0),
            onPressed: () {
              if (onPressGoogle != null) Get.to(() => onPressGoogle!);
            },
            label: Text(buttonText),
          ),
        ),
        SizedBox(height: heightBetween),
        TextButton(
          onPressed: () {
            if (onPressAlternative != null) Get.to(onPressAlternative!);
          },
          child: Text.rich(
            TextSpan(
              text: alternativeText,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: alternativeTextSpan,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}