// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';

// Project imports:

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.background = Colors.black,
    this.width = 130,
    this.height = 47,
    this.borderRadius = 25,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
  }) : super(key: key);
  final Text text;
  final Function() onPressed;
  final double width;
  final double height;
  final Color background;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: CustomColors.white,
                strokeWidth: 1,
              ))
            : Center(child: text),
      ),
    );
  }
}
