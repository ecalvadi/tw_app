import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';

import 'package:logging/logging.dart';
import 'package:dio/dio.dart';
import 'package:tw_app/data/repositories/dio_helper.dart';

import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/entities/auth/me.dart';
import 'package:tw_app/domain/entities/auth/token.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';

class DataRemoteAuthenticationRepository implements AuthenticationRepository {
  factory DataRemoteAuthenticationRepository() => _instance;
  Logger _logger;

  static final DataRemoteAuthenticationRepository _instance =
      DataRemoteAuthenticationRepository._internal();

  DataRemoteAuthenticationRepository._internal()
      : _logger = Logger('DataRemoteAuthenticationRepository');

  @override
  Future<String?> checkAuth() {
    // TODO: implement checkAuth
    throw UnimplementedError();
  }

  @override
  Future<Me> getMe() async {
    try {
      final Response<Map<String, dynamic>> response =
          await (await DioHelper().dioClient)
              .post<Map<String, dynamic>>('/api/auth/me');

      _logger.finest('DataRemoteAuthenticationRepository getMe successful.');
      final Me me = Me.fromJson(response.data!);

      return me;
    } catch (e) {
      _logger.severe('DataRemoteAuthenticationRepository getMe unsuccessful.');
      rethrow;
    }
  }

  @override
  Future<Token> login(Login login) async {
    try {
      final Map<String, dynamic> bodyRequest = login.toJson();
      final Response<Map<String, dynamic>> response =
          await (await DioHelper().dioClient).post<Map<String, dynamic>>(
        '/api/auth/login',
        data: bodyRequest,
      );

      _logger.finest('DataRemoteAuthenticationRepository login successful.');
      final Token token = Token.fromJson(response.data!);

      DioHelper().saveToken(token: token);

      return token;
    } catch (e) {
      _logger.severe('DataRemoteAuthenticationRepository login unsuccessful.');
      rethrow;
    }
  }

  @override
  Future<BuildContext> logout(BuildContext context) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
