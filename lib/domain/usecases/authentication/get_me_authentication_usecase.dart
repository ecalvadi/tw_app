import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/entities/auth/me.dart';
import 'package:tw_app/domain/repositories/authentication_repository.dart';

class GetMeAuthenticationUseCase
    extends UseCase<GetMeAuthenticationUseCaseResponse, void> {
  final AuthenticationRepository authenticationRepository;
  GetMeAuthenticationUseCase(this.authenticationRepository);

  @override
  Future<Stream<GetMeAuthenticationUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetMeAuthenticationUseCaseResponse>();

    try {
      final Me me = await authenticationRepository.getMe();
      controller.add(GetMeAuthenticationUseCaseResponse(me));
      logger.finest("GetMeAuthenticationUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("GetMeAuthenticationUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetMeAuthenticationUseCaseResponse {
  final Me? me;
  GetMeAuthenticationUseCaseResponse(this.me);
}
