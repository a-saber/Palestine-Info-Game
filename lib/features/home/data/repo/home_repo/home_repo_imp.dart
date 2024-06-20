import 'package:dartz/dartz.dart';
import 'package:word_game/core/father_repo/father_repo.dart';
import 'package:word_game/core/local/cache_keys.dart';
import 'package:word_game/core/local/cashe_helper.dart';
import 'package:word_game/features/home/data/models/cache_model.dart';
import 'package:word_game/features/home/data/repo/home_repo/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  @override
  Future<Either<String, CacheModel>> initCachData() async {
    try {
      FatherRepo.cacheModel = CacheModel(
          coinsNumber: await CacheHelper.getData(key: CacheKeys.coins) ?? 0,
          collectionIndex:
              await CacheHelper.getData(key: CacheKeys.collectionIndex) ?? 0,
          questionIndex:
              await CacheHelper.getData(key: CacheKeys.questionIndex) ?? 0,
          solvedNumber: await CacheHelper.getData(key: CacheKeys.solved) ?? 0);
      return right(FatherRepo.cacheModel!);
    } catch (e) {
      return left(e.toString());
    }
  }
}
