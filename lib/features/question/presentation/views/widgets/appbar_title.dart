import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/manager/app_states.dart';

import '../../../../../core/resources_manager/colors_manager.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                size: 60,
                color: ColorsManager.green,
              ),
              Text(
                '${CacheHelperKeys.questionIndex! + 1}',
                style: const TextStyle(
                    color: ColorsManager.secondColor, fontSize: 18),
              )
            ],
          );
        },
        listener: (context, state) {});
  }
}
