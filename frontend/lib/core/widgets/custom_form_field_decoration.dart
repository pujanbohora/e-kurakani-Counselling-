// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../theme/colors.dart';

InputDecoration customFormFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.only(left: 30.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 2.0,
      color: CustomColors.white
          .withOpacity(0.2), //Use custom colors using this way.
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
  border: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 2.0,
      color: CustomColors.primary,
    ),
    borderRadius: BorderRadius.circular(12.0),
  ),
);
