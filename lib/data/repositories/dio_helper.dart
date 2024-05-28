import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:tw_app/constants.dart';
import 'package:tw_app/domain/entities/auth/token.dart';
import 'package:tw_app/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  final Logger _logger = Logger('DioHelper');

  static final DioHelper _singleton = DioHelper._internal();

  factory DioHelper() {
    return _singleton;
  }

  DioHelper._internal();

  BuildContext? context;

  Future<Dio> get dioClient async {
    final String url = await getUrlBase();
    final BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    Dio dio = Dio(options);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      if (options.path != '/api/auth/login') {
        String tokenStr = preferences.getString(Constants.token)!;
        Token token = Token.fromJson(jsonDecode(tokenStr));

        options.headers['Authorization'] = 'Bearer ${token.token}';
      }

      final String? contentType;
      final dynamic data = options.data;
      if (data is FormData) {
        contentType = Headers.multipartFormDataContentType;
      } else if (data is Map) {
        contentType = Headers.jsonContentType;
      } else if (data is String) {
        contentType = Headers.jsonContentType;
      } else if (data != null) {
        contentType =
            Headers.textPlainContentType; // Can be removed if unnecessary.
      } else {
        contentType = Headers.jsonContentType;
      }
      options.contentType = contentType;

      return handler.next(options);
    }, onError: (error, handler) {
      // TODO: hacer algo con el error
      return handler.next(error);
    }));

    return dio;
  }

  Future<void> saveToken({required Token token}) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setString(Constants.token, jsonEncode(token.toJson())),
      ]);

      _logger.finest('Token successfully stored.');
    } catch (error, _) {
      _logger.warning('_saveToken.', error);
    }
  }

  static Future<String> getUrlBase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String schema = env['API_SCHEME']!;
    String host = env['API_HOST']!;
    String port = env['API_PORT']!;

    if (port.isNotEmpty) {
      return "$schema://$host:$port";
    } else {
      return "$schema://$host";
    }
  }
}
