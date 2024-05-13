import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/repositories/position_repository.dart';

class UpdatePositionUseCase extends UseCase<UpdatePositionUseCaseResponse,
    UpdatePositionUseCaseParams> {
  final PositionRepository positionRepository;
  UpdatePositionUseCase(this.positionRepository);

  @override
  Future<Stream<UpdatePositionUseCaseResponse>> buildUseCaseStream(
      UpdatePositionUseCaseParams? params) async {
    final controller = StreamController<UpdatePositionUseCaseResponse>();

    try {
      final Position position =
          await positionRepository.updatePosition(params!.position);
      controller.add(UpdatePositionUseCaseResponse(position));
      logger.finest("UpdatePositionUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("UpdatePositionUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class UpdatePositionUseCaseParams {
  final Position position;
  UpdatePositionUseCaseParams(this.position);
}

class UpdatePositionUseCaseResponse {
  final Position? position;
  UpdatePositionUseCaseResponse(this.position);
}
