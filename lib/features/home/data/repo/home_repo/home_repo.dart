import 'package:dartz/dartz.dart';

import 'package:word_game/core/models/question_group.dart';

abstract class HomeRepo {
  Future<Either<String, QuestionGroup?>> getGroup();
}
