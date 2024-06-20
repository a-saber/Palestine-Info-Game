import 'package:dartz/dartz.dart';

import 'package:word_game/features/home/data/models/cache_model.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';

abstract class QuestionRepo {
  Future<Either<String, CacheModel>> restart();

  Future<Either<String, QueUpResponse>> questionUp();

  Future<Either<String, CacheModel>> editCoins(
      {required EditCoinsType editCoinsType});
}
