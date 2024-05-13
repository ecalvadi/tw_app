import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';

class CheckAuthAuthenticationUseCase
    extends UseCase<CheckAuthAuthenticationUseCaseResponse, void> {
  CheckAuthAuthenticationUseCase(this.authenticationRepository);
  final AuthenticationRepository authenticationRepository;

  @override
  Future<Stream<CheckAuthAuthenticationUseCaseResponse?>> buildUseCaseStream(
      void params) async {
    final controller =
        StreamController<CheckAuthAuthenticationUseCaseResponse>();

    try {
      final String? token = await authenticationRepository.checkAuth();
      controller.add(CheckAuthAuthenticationUseCaseResponse(token));
      logger.finest('CheckAuthAuthenticationUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('CheckAuthAuthenticationUseCase unsuccessful.');
      controller.addError(e);
    }

    return controller.stream;
  }
}

class CheckAuthAuthenticationUseCaseResponse {
  final String? token;
  CheckAuthAuthenticationUseCaseResponse(this.token);
}
