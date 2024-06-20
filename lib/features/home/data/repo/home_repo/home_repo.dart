import 'package:dartz/dartz.dart';

import 'package:word_game/features/home/data/models/cache_model.dart';

abstract class HomeRepo {
  Future<Either<String, CacheModel>> initCachData();
}
