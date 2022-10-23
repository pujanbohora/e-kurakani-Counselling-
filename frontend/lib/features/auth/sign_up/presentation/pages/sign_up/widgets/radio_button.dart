// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';

Widget buildIndividualRadio(
    {required String value,
    required String groupValue,
    required Function(String) onclick}) {
  return Row(
    children: [
      Radio<String>(
        fillColor:
            MaterialStateColor.resolveWith((states) => CustomColors.black),
        toggleable: true,
        // activeColor: AppColors.darkBlack,
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          onclick(value!);
        },
      ),
      Text(value),
    ],
  );
}
