import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/local/cashe_helper.dart';

Future initCachData() async {
  CacheHelperKeys.collectionIndex =
      await CacheHelper.getData(key: CacheHelperKeys.collectionIndexKey);
  CacheHelperKeys.questionIndex =
      await CacheHelper.getData(key: CacheHelperKeys.questionIndexKey);
  CacheHelperKeys.coinsNumber =
      await CacheHelper.getData(key: CacheHelperKeys.coinsKey);
  CacheHelperKeys.solvedNumber =
      await CacheHelper.getData(key: CacheHelperKeys.solvedKey);
  if (CacheHelperKeys.collectionIndex == null) {
    await CacheHelper.saveData(
        key: CacheHelperKeys.collectionIndexKey, value: 0);
    CacheHelperKeys.collectionIndex = 0;
  }
  if (CacheHelperKeys.questionIndex == null) {
    await CacheHelper.saveData(key: CacheHelperKeys.questionIndexKey, value: 0);
    CacheHelperKeys.questionIndex = 0;
  }
  if (CacheHelperKeys.coinsNumber == null) {
    await CacheHelper.saveData(key: CacheHelperKeys.coinsKey, value: 0);
    CacheHelperKeys.coinsNumber = 0;
  }
  if (CacheHelperKeys.solvedNumber == null) {
    await CacheHelper.saveData(key: CacheHelperKeys.solvedKey, value: 0);
    CacheHelperKeys.solvedNumber = 0;
  }
  print('22222222222222222222222222');
  print(CacheHelperKeys.collectionIndex);
  print(CacheHelperKeys.questionIndex);
  print(CacheHelperKeys.coinsNumber);
  print(CacheHelperKeys.solvedNumber);
}
