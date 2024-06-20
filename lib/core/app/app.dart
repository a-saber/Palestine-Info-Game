import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:word_game/core/core_widget/my_snack_bar.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/constant_manager.dart';
import 'package:word_game/core/service_manager/service_locator.dart';
import 'package:word_game/features/groups/data/repo/group_repo/group_repo_imp.dart';
import 'package:word_game/features/home/data/repo/home_repo/home_repo_imp.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_state.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/home/presentation/views/home_view.dart';
import 'package:word_game/features/question/data/repo/question_repo/question_repo_imp.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/restart_cubit/restart_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  CacheCubit(getIt.get<HomeRepoImp>())..initCachData()),
          BlocProvider(create: (context) => QuestionUICubit()),
          BlocProvider(
              create: (context) =>
                  GetGroupCubit(getIt.get<GroupRepoImp>())..getCurrentGroup()),
          BlocProvider(
              create: (context) =>
                  EditCoinsCubit(getIt.get<QuestionRepoImp>())),
          BlocProvider(
              create: (context) => RestartCubit(getIt.get<QuestionRepoImp>())),
          BlocProvider(
              create: (context) => QueUpCubit(getIt.get<QuestionRepoImp>())),
        ],
        child: BlocListener<CacheCubit, CacheState>(
            listener: (context, state) {
              if (state is CacheErrorState) {
                callMySnackBar(context: context, text: state.error);
              }
            },
            child: GetMaterialApp(
                themeMode: ThemeMode.light,
                textDirection: TextDirection.rtl,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    fontFamily: 'Cairo',
                    useMaterial3: true,
                    appBarTheme:
                        const AppBarTheme(backgroundColor: ColorsManager.white),
                    scaffoldBackgroundColor: ColorsManager.white),
                title: ConstantManager.appName,
                home: const HomeView())));
  }
}
