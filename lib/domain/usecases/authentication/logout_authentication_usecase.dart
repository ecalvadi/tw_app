import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/repositories/authentication_repository.dart';

class LogoutAuthenticationUseCase extends UseCase<
    LogoutAuthenticationUseCaseResponse, LogoutAuthenticationUseCaseParams> {
  final AuthenticationRepository authenticationRepository;
  LogoutAuthenticationUseCase(this.authenticationRepository);

  @override
  Future<Stream<LogoutAuthenticationUseCaseResponse>> buildUseCaseStream(
      LogoutAuthenticationUseCaseParams? params) async {
    final controller = StreamController<LogoutAuthenticationUseCaseResponse>();

    try {
      final BuildContext context =
          await authenticationRepository.logout(params!.context);
      controller.add(LogoutAuthenticationUseCaseResponse(context));
      logger.finest("LogoutAuthenticationUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("LogoutAuthenticationUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class LogoutAuthenticationUseCaseParams {
  final BuildContext context;
  LogoutAuthenticationUseCaseParams(this.context);
}

class LogoutAuthenticationUseCaseResponse {
  final BuildContext? context;
  LogoutAuthenticationUseCaseResponse(this.context);
}
