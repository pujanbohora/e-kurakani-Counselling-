// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {Key? key,
      required this.color,
      this.BorderColor,
      this.searchIcon,
      required this.hintText})
      : super(key: key);

  final Color color;
  final Color? BorderColor;
  final IconData? searchIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: BorderColor ?? CustomColors.black,
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      searchIcon ?? EvaIcons.searchOutline,
                      color: CustomColors.neutral,
                    ),
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
