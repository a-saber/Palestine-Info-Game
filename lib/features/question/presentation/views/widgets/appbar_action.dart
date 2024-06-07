import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';

import '../../../../../core/manager/app_cubit.dart';
import '../../../../../core/manager/app_states.dart';
import '../../../../../core/resources_manager/colors_manager.dart';

class AppbarAction extends StatelessWidget {
  const AppbarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  "${CacheHelperKeys.coinsNumber}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.black),
                ),
                SizedBox(
                  width: 4.0,
                ),
                const Icon(
                  FontAwesomeIcons.coins,
                  color: ColorsManager.green,
                  size: 22,
                ),
              ],
            ));
      },
      listener: (context, state) {},
    );
  }
}
