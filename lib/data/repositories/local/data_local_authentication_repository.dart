import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tw_app/constants.dart';

import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/entities/auth/me.dart';
import 'package:tw_app/domain/entities/auth/token.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';

class DataLocalAuthenticationRepository implements AuthenticationRepository {
  factory DataLocalAuthenticationRepository() => _instance;
  Logger _logger;

  static final DataLocalAuthenticationRepository _instance =
      DataLocalAuthenticationRepository._internal();

  DataLocalAuthenticationRepository._internal()
      : _logger = Logger('DataLocalAuthenticationRepository');

  @override
  Future<String?> checkAuth() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(Constants.token);
  }

  @override
  Future<Me> getMe() {
    // TODO: implement getMe
    throw UnimplementedError();
  }

  @override
  Future<Token> login(Login login) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<BuildContext> logout(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
    return context;
  }
}
