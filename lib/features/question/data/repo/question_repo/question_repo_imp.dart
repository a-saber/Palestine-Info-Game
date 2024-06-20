import 'package:dartz/dartz.dart';
import 'package:word_game/core/father_repo/father_repo.dart';
import 'package:word_game/core/local/cache_keys.dart';
import 'package:word_game/core/local/cashe_helper.dart';
import 'package:word_game/features/home/data/models/cache_model.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_state.dart';

class QuestionRepoImp extends QuestionRepo {
  @override
  Future<Either<String, CacheModel>> restart() async {
    try {
      await CacheHelper.saveData(key: CacheKeys.collectionIndex, value: 0);
      await CacheHelper.saveData(key: CacheKeys.questionIndex, value: 0);
      await CacheHelper.saveData(key: CacheKeys.coins, value: 0);
      await CacheHelper.saveData(key: CacheKeys.solved, value: 0);

      FatherRepo.cacheModel = CacheModel(
          coinsNumber: 0,
          collectionIndex: 0,
          questionIndex: 0,
          solvedNumber: 0);

      return right(FatherRepo.cacheModel!);
    } catch (e) {
      print(e.toString());
      return left('Sorry, There is an error please try again later');
    }
  }

  @override
  Future<Either<String, CacheModel>> editCoins(
      {required EditCoinsType editCoinsType}) async {
    try {
      int value = 0;
      switch (editCoinsType) {
        case EditCoinsType.praise:
          value = 5;
          FatherRepo.cacheModel!.editMinus = false;
          break;
        case EditCoinsType.question:
          value = 5;
          FatherRepo.cacheModel!.editMinus = false;
          break;
        case EditCoinsType.help:
          value = -5;
          FatherRepo.cacheModel!.editMinus = true;
          break;
        default:
      }
      FatherRepo.cacheModel!.coinsNumber =
          FatherRepo.cacheModel!.coinsNumber + value;
      await CacheHelper.saveData(
          key: CacheKeys.coins, value: FatherRepo.cacheModel!.coinsNumber);
      return right(FatherRepo.cacheModel!);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, QueUpResponse>> questionUp() async {
    try {
      QueUpState queUpState;
      if (FatherRepo.cacheModel!.questionIndex < 4) {
        FatherRepo.cacheModel!.questionIndex =
            FatherRepo.cacheModel!.questionIndex + 1;
        queUpState = QueUpSuccessState();
      } else {
        FatherRepo.cacheModel!.collectionIndex =
            FatherRepo.cacheModel!.collectionIndex + 1;
        FatherRepo.cacheModel!.questionIndex = 0;

        if (FatherRepo.cacheModel!.collectionIndex ==
            FatherRepo.groupResponse!.groupsTotalNo) {
          queUpState = QueGameDoneSuccessState();
        } else {
          queUpState = QueLevelUpSuccessState();
        }
        await CacheHelper.saveData(
            key: CacheKeys.collectionIndex,
            value: FatherRepo.cacheModel!.collectionIndex);
      }
      await CacheHelper.saveData(
          key: CacheKeys.questionIndex,
          value: FatherRepo.cacheModel!.questionIndex);
      return right(QueUpResponse(
          cacheModel: FatherRepo.cacheModel!, queUpState: queUpState));
    } catch (e) {
      print(e.toString());
      return left('Sorry, There is an error please try again later');
    }
  }
}
