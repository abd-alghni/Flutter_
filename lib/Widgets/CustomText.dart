import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;
  final Alignment? aligment;

  CustomText({
    this.title,
    this.size = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.aligment,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title!,
        style: TextStyle(
          fontSize: size,
          color: color!,
          fontWeight: fontWeight!,
        ),
      ),
    );
  }
}
