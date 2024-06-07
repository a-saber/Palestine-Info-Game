import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/manager/app_cubit.dart';
import 'package:word_game/core/manager/app_states.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/features/question/presentation/views/widgets/question_image_view.dart';
import 'package:word_game/main.dart';

import '../../../../../core/core_widget/alerts/alert_game_done.dart';
import '../../../../../core/core_widget/alerts/alert_level_done.dart';
import '../../../../../core/resources_manager/delay_manager.dart';
import 'actions_row.dart';
import 'answer.dart';

class QuestionViewBody extends StatefulWidget {
  const QuestionViewBody({Key? key}) : super(key: key);

  @override
  State<QuestionViewBody> createState() => _QuestionViewBodyState();
}

class _QuestionViewBodyState extends State<QuestionViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppCubit.get(context)
                    .collections[CacheHelperKeys.collectionIndex!]
                    .questions[CacheHelperKeys.questionIndex!]
                    .isImage
                ? QuestionImageView(
                    image: AppCubit.get(context)
                        .collections[CacheHelperKeys.collectionIndex!]
                        .questions[CacheHelperKeys.questionIndex!]
                        .text)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      AppCubit.get(context)
                          .collections[CacheHelperKeys.collectionIndex!]
                          .questions[CacheHelperKeys.questionIndex!]
                          .text,
                      style: TextStyle(
                        fontSize: height > 600 ? 35 : height * 0.05,
                        color: ColorsManager.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
            Column(
              children: [
                const ActionsRow(),
                const SizedBox(
                  height: 15,
                ),
                AnimatedBuilder(
                    animation: slidingAnimation,
                    builder: (context, _) {
                      return SlideTransition(
                          position: slidingAnimation, child: const Answer());
                    }),
              ],
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is GameDoneState) {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => alertGameDone(context),
          barrierDismissible: false,
        );
      }
      if (state is LevelDoneState) {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => alertLevelDone(context),
          barrierDismissible: false,
        );
      }
    });
  }

  void initAnimation() {
    animationController = AnimationController(
        vsync: this, duration: DelayManager.durationAnswerAppear);
    slidingAnimation =
        DelayManager.tweenAnswerAppearAnimation.animate(animationController);
    animationController.forward();
    slidingAnimation.addListener(() {
      setState(() {});
    });
  }
}
