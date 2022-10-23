// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Project imports:
import 'package:frontend/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectable.dart';

Future<bool> get getCurrentUser async {
  try {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    String? accessToken = await secureStorage.read(key: Consts.ACCESS_TOKEN);
    String? refreshToken = await secureStorage.read(key: Consts.REFRESH_TOKEN);

    if (accessToken == null || refreshToken == null) {
      return false;
    }
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> get logOutCurrentUser async {
  var preference = getIt<SharedPreferences>();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  await secureStorage.deleteAll();
  await preference.clear();
}
