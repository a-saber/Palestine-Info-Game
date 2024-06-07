import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/local/cashe_helper.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/constant_manager.dart';
import 'package:word_game/features/home/presentation/views/home_view.dart';

import 'core/manager/app_cubit.dart';

late double height;
late double width;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await initCacheVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: GetMaterialApp(
            themeMode: ThemeMode.light,
            textDirection: TextDirection.rtl,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Cairo',
                useMaterial3: true,
                scaffoldBackgroundColor: ColorsManager.white),
            title: ConstantManager.appName,
            home: const HomeView()));
  }
}

Future initCacheVariables() async {
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
