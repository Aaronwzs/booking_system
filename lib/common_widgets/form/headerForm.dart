import 'package:flutter/material.dart';

// ignore: camel_case_types
class headerform extends StatelessWidget {
  const headerform({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageColor,
    this.heightBetween,
    this.imageHeight = 0.1,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.center,});

  //Variables
  final String image, title, subTitle;
  final Color? imageColor;
  final double? heightBetween;
  final double imageHeight;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          color: imageColor,
          height: size.height * imageHeight,
        ),
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        Text(subTitle, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  
}