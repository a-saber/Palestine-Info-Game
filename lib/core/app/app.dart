import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/constant_manager.dart';
import 'package:word_game/features/home/presentation/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
        ],
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
