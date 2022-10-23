// Flutter imports:
import 'package:flutter/material.dart';

class InteractiveButton extends StatelessWidget {
  const InteractiveButton(
      {required this.onPressed, required this.buttonName, Key? key})
      : super(key: key);

  final Function() onPressed;
  final Text buttonName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          backgroundColor: const Color(0xFfF0F0F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29.0),
          ),
          primary: const Color(0xFF1C1C1C),
        ),
        child: buttonName,
        onPressed: onPressed);
  }
}
