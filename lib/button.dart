// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final color;
  final textColor;
  final text;
  final buttonTapped;

  const button(
      {super.key,
      required this.color,
      required this.textColor,
      required this.text,
      required this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
