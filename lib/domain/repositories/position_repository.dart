import 'package:tw_app/domain/entities/position.dart';

abstract class PositionRepository {
  Future<Position> create(Position position);
  Future<Position> getMePosition();
  Future<Position> updatePosition(Position position);
}
