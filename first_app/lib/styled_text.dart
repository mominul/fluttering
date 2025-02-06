import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText({required this.text, this.size, this.color, super.key});

  final String text;
  final double? size;
  final Color? color;

  @override
  Widget build(context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size ?? 30,
        color: color ?? Colors.black,
      ),
    );
  }
}
