// ignore_for_file: prefer_initializing_formals

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';

@injectable
class CachedValues {
  static SharedPreferences? cache;

  CachedValues(SharedPreferences cache) {
    CachedValues.cache = cache;
  }

  static UserModel? getUserInfo() {
    String? userInfo = cache!.getString(Consts.USER_INFO);

    if (userInfo != null) {
      UserModel userModel =
          UserModel.fromJson(userInfo as Map<String, dynamic>);
      return userModel;
    }
    return null;
  }

  static saveUserInfo(UserModel userModel) async {
    return await cache!
        .setString(Consts.USER_INFO, jsonEncode(userModel.toJson()));
  }
}
