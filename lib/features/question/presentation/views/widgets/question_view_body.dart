import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/resources_manager/colors_manager.dart';
import 'package:word_game/core/resources_manager/style_manager.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_state.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_state.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_cubit.dart';
import 'package:word_game/features/question/presentation/views/widgets/question_image_view.dart';
import '../../../../../core/resources_manager/delay_manager.dart';
import 'actions_row.dart';
import 'answer.dart';

class QuestionViewBody extends StatefulWidget {
  const QuestionViewBody({super.key});

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
    return BlocConsumer<GetGroupCubit, GetGroupState>(
        builder: (context, state) {
      if (state is GetGroupAllDoneState) {
        return Center(
          child: Text(
            'لقد اتممت جميع مراحل الاسئلة',
            textAlign: TextAlign.center,
            style: StyleManager.bold
                .copyWith(color: ColorsManager.green, fontSize: 25),
          ),
        );
      }
      return Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child:
              BlocBuilder<CacheCubit, CacheState>(builder: ((context, state) {
            if (CacheCubit.get(context).cacheModel != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    Widget widget;
                    if (GetGroupCubit.get(context)
                        .groupResponse!
                        .group!
                        .questions[
                            CacheCubit.get(context).cacheModel!.questionIndex]
                        .isImage) {
                      widget = QuestionImageView(
                          image: GetGroupCubit.get(context)
                              .groupResponse!
                              .group!
                              .questions[CacheCubit.get(context)
                                  .cacheModel!
                                  .questionIndex]
                              .image!);
                    } else {
                      widget = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          GetGroupCubit.get(context)
                              .groupResponse!
                              .group!
                              .questions[CacheCubit.get(context)
                                  .cacheModel!
                                  .questionIndex]
                              .text,
                          style: TextStyle(
                            fontSize: height > 600 ? 35 : height * 0.05,
                            color: ColorsManager.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return widget;
                  }),
                  Column(
                    children: [
                      //const ActionsRow(),
                      const SizedBox(
                        height: 15,
                      ),
                      AnimatedBuilder(
                          animation: slidingAnimation,
                          builder: (context, _) {
                            return SlideTransition(
                                position: slidingAnimation,
                                child: const Answer());
                          }),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox();
          })));
    }, listener: (context, state) {
      /* if (state is GameDoneState) {
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
      }*/
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
