import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/entities/auth/login.dart';
import 'package:tw_app/domain/entities/auth/token.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';

class LoginAuthenticationUseCase extends UseCase<
    LoginAuthenticationUseCaseResponse, LoginAuthenticationUseCaseParams> {
  final AuthenticationRepository authenticationRepository;
  LoginAuthenticationUseCase(this.authenticationRepository);

  @override
  Future<Stream<LoginAuthenticationUseCaseResponse>> buildUseCaseStream(
      LoginAuthenticationUseCaseParams? params) async {
    final controller = StreamController<LoginAuthenticationUseCaseResponse>();

    try {
      final Token token = await authenticationRepository.login(params!.login);
      controller.add(LoginAuthenticationUseCaseResponse(token));
      logger.finest("LoginAuthenticationUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("LoginAuthenticationUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class LoginAuthenticationUseCaseParams {
  final Login login;
  LoginAuthenticationUseCaseParams(this.login);
}

class LoginAuthenticationUseCaseResponse {
  final Token? token;
  LoginAuthenticationUseCaseResponse(this.token);
}
