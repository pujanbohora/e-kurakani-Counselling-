// this is for local database repo
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/core/error/exception.dart';
import 'package:frontend/core/utils/constants.dart';
import 'package:frontend/features/auth/sign_up/data/model/sign_in_reponse_model.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CreateCounsellorLocalDataSource {
  Future<void> saveCredentialsDataToLocal(
      SignInResponseModel? signInResponseModel);

  Future<dynamic> getUserModelDataFromLocal();
  Future<void> saveUserDataToLocal(UserModel userData);
  // Future<void> getUserDataToLocal();
}

@Injectable(as: CreateCounsellorLocalDataSource)
class CreateCounsellorLocalDataSourceImpl
    implements CreateCounsellorLocalDataSource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // CachedValues.cache = getIt<SharedPreferences>();

  @override
  Future<void> saveCredentialsDataToLocal(
      SignInResponseModel? signInResponseModel) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

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
  Future<dynamic> getUserModelDataFromLocal() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    final Map<String, dynamic>? keys =
        jsonDecode(preference.getString(Consts.USER_INFO)!)
            as Map<String, dynamic>;
    return keys;
  }

  @override
  Future<void> saveUserDataToLocal(UserModel userData) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      if (userData.email != null) {
        //save key
        await preference.setString(
            Consts.USER_INFO, jsonEncode(userData.email));

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
