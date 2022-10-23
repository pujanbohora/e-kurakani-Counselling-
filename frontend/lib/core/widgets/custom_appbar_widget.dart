// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/get_current_user.dart';

PreferredSizeWidget appBar({
  required bool noBackButton,
  required String navTitle,
  Color? appBarBackgroupColor,
  Widget? settingIcon,
  Color? textColor,
  Color? iconColor,
  required Function() backNavigate,
}) {
  return AppBar(
    backgroundColor: const Color(0xffE4F2F7),
    elevation: 0,
    leading: noBackButton
        ? Container()
        : const BackButton(
            color: Colors.black,
          ),
    title: Text(
      navTitle,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    centerTitle: false,
  );
}
