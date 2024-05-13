import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/repositories/position_repository.dart';

class GetMePositionUseCase extends UseCase<GetMePositionUseCaseResponse, void> {
  final PositionRepository positionRepository;
  GetMePositionUseCase(this.positionRepository);

  @override
  Future<Stream<GetMePositionUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetMePositionUseCaseResponse>();

    try {
      final Position position = await positionRepository.getMePosition();
      controller.add(GetMePositionUseCaseResponse(position));
      logger.finest("GetMePositionUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("GetMePositionUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetMePositionUseCaseResponse {
  final Position? position;
  GetMePositionUseCaseResponse(this.position);
}
