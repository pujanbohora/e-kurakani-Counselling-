// this is for local database repo

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';

@module
abstract class InjectionModule {
//injecting third party libraries
  @preResolve
  Future<SharedPreferences> get preference => SharedPreferences.getInstance();
}

abstract class SignUpLocalDataSource {
  Future<void> saveCredentialsDataToLocal(
      SignInResponseModel? signInResponseModel);

  Future<UserModel?> getUserDataFromLocal();
  Future<void> saveUserDataToLocal(UserModel userData);
  // Future<void> getUserDataToLocal();
}

@Injectable(as: SignUpLocalDataSource)
class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // CachedValues.cache = getIt<SharedPreferences>();

  final preference = getIt<SharedPreferences>();

  @override
  Future<void> saveCredentialsDataToLocal(
      SignInResponseModel? signInResponseModel) async {
    // SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      if (signInResponseModel!.user != null) {
        await preference.setString(
            Consts.USER_INFO, jsonEncode(signInResponseModel.user));

        //  UserModel key = await preference.get(Consts.USER_INFO)

        final Map<String, dynamic>? keys =
            jsonDecode(preference.getString(Consts.USER_INFO)!)
                as Map<String, dynamic>;

        if (keys!["is_active"] == true) {
          secureStorage.write(
              key: Consts.REFRESH_TOKEN, value: (signInResponseModel.refresh));
          secureStorage.write(
              key: Consts.ACCESS_TOKEN, value: signInResponseModel.access);

          String? accessToken =
              await secureStorage.read(key: Consts.ACCESS_TOKEN);
        }
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<UserModel?> getUserDataFromLocal() async {
    String? userInfo = preference.getString(Consts.USER_INFO);

    if (userInfo != null) {
      UserModel userInfoDecoded =
          UserModel.fromJson(jsonDecode(userInfo) as Map<String, dynamic>);

      return userInfoDecoded;
    }

    return null;
  }

  @override
  Future<void> saveUserDataToLocal(UserModel userData) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      if (userData.email != null) {
        //save key
        await preference.setString(Consts.USER_INFO, jsonEncode(userData));

        //get key
        dynamic key = await preference.get(Consts.USER_INFO);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<UserModel?> getUserDataToLocal() async {
    // ignore: todo
    //TODO: implement getUserDataToLocal
    // UserModel? data = await CachedValues.getUserInfo();
    // return data;
  }
}
