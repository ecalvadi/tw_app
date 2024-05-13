import 'package:logging/logging.dart';
import 'package:dio/dio.dart';
import 'package:tw_app/data/repositories/dio_helper.dart';

import 'package:tw_app/domain/entities/position.dart';
import 'package:tw_app/domain/repositories/position_repository.dart';

class DataRemotePositionRepository implements PositionRepository {
  factory DataRemotePositionRepository() => _instance;
  Logger _logger;

  static final DataRemotePositionRepository _instance =
      DataRemotePositionRepository._internal();

  DataRemotePositionRepository._internal()
      : _logger = Logger('DataRemotePositionRepository');

  @override
  Future<Position> create(Position position) async {
    try {
      final Map<String, dynamic> bodyRequest = position.toJson();
      final Response<Map<String, dynamic>> response =
          await (await DioHelper().dioClient).post<Map<String, dynamic>>(
        '/api/positions',
        data: bodyRequest,
      );

      _logger.finest('DataRemotePositionRepository create successful.');
      final Position newPos = Position.fromJson(response.data!);

      return newPos;
    } catch (e) {
      _logger.severe('DataRemotePositionRepository create unsuccessful.');
      rethrow;
    }
  }

  @override
  Future<Position> getMePosition() async {
    try {
      final Response<Map<String, dynamic>> response =
          await (await DioHelper().dioClient)
              .get<Map<String, dynamic>>('/api/positions/byUser');

      _logger.finest('DataRemotePositionRepository getMePosition successful.');
      final Position position = Position.fromJson(response.data!);

      return position;
    } catch (e) {
      _logger
          .severe('DataRemotePositionRepository getMePosition unsuccessful.');
      rethrow;
    }
  }

  @override
  Future<Position> updatePosition(Position position) async {
    try {
      final Map<String, dynamic> bodyRequest = position.toJson();
      final Response<Map<String, dynamic>> response =
          await (await DioHelper().dioClient).put<Map<String, dynamic>>(
        '/api/positions/${position.id}',
        data: bodyRequest,
      );

      _logger.finest('DataRemotePositionRepository update successful.');
      final Position updatedPos = Position.fromJson(response.data!);

      return updatedPos;
    } catch (e) {
      _logger.severe('DataRemotePositionRepository update unsuccessful.');
      rethrow;
    }
  }
}
