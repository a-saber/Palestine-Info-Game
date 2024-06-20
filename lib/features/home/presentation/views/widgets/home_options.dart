import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:word_game/core/core_widget/alerts/alert_restart.dart';
import 'package:word_game/core/core_widget/default_button.dart';
import 'package:word_game/core/core_widget/my_snack_bar.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';
import 'package:word_game/features/groups/presentation/views/group_view.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/restart_cubit/restart_state.dart';
import 'package:word_game/features/question/presentation/cubit/restart_cubit/restart_cubit.dart';
import 'coins_view_body.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key, required this.slidingAnimation});
  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (BuildContext context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Column(
            children: [
              DefaultButton(
                onPressed: () {
                  Get.to(() => const GroupsView(),
                      transition: DelayManager.rightToLeft,
                      duration: const Duration(milliseconds: 500));
                },
                text: 'ابدأ',
              ),
              DefaultButton(
                onPressed: () {
                  Get.to(() => const Coins(),
                      transition: DelayManager.rightToLeft,
                      duration: const Duration(milliseconds: 500));
                },
                text: 'كسب النقاط',
              ),
              BlocListener<RestartCubit, RestartState>(
                  listener: (context, state) async {
                    if (state is RestartSuccessState) {
                      callMySnackBar(
                          context: context,
                          text: 'تم اعادة تشغيل اللعبة بنجاح');
                      CacheCubit.get(context)
                          .assignCacheModel(cacheModel: state.cacheModel);
                      await GetGroupCubit.get(context).getCurrentGroup();
                    } else if (state is RestartErrorState) {
                      callMySnackBar(context: context, text: state.error);
                    }
                  },
                  child: DefaultButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) => alertRestart(context),
                          barrierDismissible: false);
                    },
                    text: 'إعادة التشغيل',
                  )),
            ],
          ),
        );
      },
    );
  }
}
