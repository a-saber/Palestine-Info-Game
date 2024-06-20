import 'package:dartz/dartz.dart';
import 'package:word_game/core/models/response_model.dart';

abstract class GroupRepo {
  Future<Either<String, GroupResponse?>> getGroup();
}
