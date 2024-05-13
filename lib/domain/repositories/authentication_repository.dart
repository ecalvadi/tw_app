import 'package:flutter/material.dart';
import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/entities/auth/token.dart';
import 'package:tw_app/domain/entities/auth/me.dart';

abstract class AuthenticationRepository {
  Future<Token> login(Login login);
  Future<Me> getMe();
  Future<BuildContext> logout(BuildContext context);
}
