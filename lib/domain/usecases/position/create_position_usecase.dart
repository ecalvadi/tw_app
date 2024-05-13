import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/repositories/position_repository.dart';

class CreatePositionUseCase extends UseCase<CreatePositionUseCaseResponse,
    CreatePositionUseCaseParams> {
  final PositionRepository positionRepository;
  CreatePositionUseCase(this.positionRepository);

  @override
  Future<Stream<CreatePositionUseCaseResponse>> buildUseCaseStream(
      CreatePositionUseCaseParams? params) async {
    final controller = StreamController<CreatePositionUseCaseResponse>();

    try {
      final Position position =
          await positionRepository.create(params!.position);
      controller.add(CreatePositionUseCaseResponse(position));
      logger.finest("CreatePositionUseCase successful.");
      controller.close();
    } catch (e) {
      logger.severe("CreatePositionUseCase unsuccessful.");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class CreatePositionUseCaseParams {
  final Position position;
  CreatePositionUseCaseParams(this.position);
}

class CreatePositionUseCaseResponse {
  final Position? position;
  CreatePositionUseCaseResponse(this.position);
}
