// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Project imports:
import 'package:frontend/core/network_services/urls/network_info.dart';
import 'package:frontend/core/utils/constants.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

// Dio createDio() {
//   return Dio(BaseOptions(
//     connectTimeout: _defaultConnectTimeout,
//     receiveTimeout: _defaultReceiveTimeout,
//     baseUrl: Urls.BASE_URL,
//   ))
//     ..interceptors.add();
// }

class DioClient {
  final String baseUrl;

  final Dio _dio;

  final List<Interceptor> interceptors;

  DioClient({
    required this.baseUrl,
    required Dio dio,
    required this.interceptors,
  }) : _dio = dio {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter;
    // ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false,
        ),
      );
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

class EKurakaniInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  final Dio _dio;
  EKurakaniInterceptor(FlutterSecureStorage secureStorage, Dio dio)
      : _secureStorage = secureStorage,
        _dio = dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // ignore: unrelated_type_equality_checks
    if (options.path != Urls.LOGIN_WITH_PASSWORD &&
        options.path != Urls.REGISTER_URL &&
        options.path != Urls.BASE_URL + '/core/refresh-jwt/' &&
        options.path != Urls.RESET_NEW_PASSWORD) {
      final token = await _secureStorage.read(key: Consts.ACCESS_TOKEN);
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    // debugPrint('REQUEST[${options.method}] => PATH: ${options.headers}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // debugPrint(
    //   'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    // );
    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    // check the type of error here
    // if rhe token is expired check for the forbidden access status code
    // and get the new token save it to the localstorage and
    // request again
    // debugPrint(
    //   'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    // );
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      try {
        final refresh_token =
            await _secureStorage.read(key: Consts.REFRESH_TOKEN);
        Dio dioObj = Dio();
        final response = await _dio.post("/core/refresh-jwt/",
            data: jsonEncode(
              {
                "refresh": refresh_token,
              },
            ));
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData =
              response.data as Map<String, dynamic>;
          String new_access_token = responseData["access"];
          String new_refresh_token = responseData["refresh"];
          _secureStorage.write(
              key: Consts.REFRESH_TOKEN, value: new_refresh_token);
          _secureStorage.write(
              key: Consts.ACCESS_TOKEN, value: new_access_token);
          //set bearer
          err.requestOptions.headers["Authorization"] =
              "Bearer " + new_access_token;
          //create request with new access token
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );
          final cloneReq = await _dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(cloneReq);
        }
        return super.onError(err, handler);
      } catch (e, st) {
        // debugPrint("error");
      }
    }
    return super.onError(err, handler);
  }
}

Dio dioObj = Dio();
DioClient dioClient = DioClient(
  baseUrl: Urls.BASE_URL,
  dio: dioObj,
  interceptors: [EKurakaniInterceptor(const FlutterSecureStorage(), dioObj)],
);
