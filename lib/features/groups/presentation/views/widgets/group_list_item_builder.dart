import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/core/core_widget/default_group_button.dart';
import 'package:word_game/core/resources_manager/delay_manager.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/home/presentation/cubit/cache_cubit/cache_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_cubit.dart';
import 'package:word_game/features/question/presentation/views/question_view.dart';

class GroupListItemBuilder extends StatelessWidget {
  const GroupListItemBuilder({
    super.key,
    required this.scale,
    required this.isAllDone,
  });

  final double scale;
  final bool isAllDone;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, int index) => Transform.scale(
                scale: isAllDone
                    ? 1
                    : CacheCubit.get(context).cacheModel!.collectionIndex ==
                            index
                        ? scale
                        : 1,
                origin: const Offset(50, 50),
                child: DefaultGroupButton(
                  disableColored:
                      CacheCubit.get(context).cacheModel!.collectionIndex >
                          index,
                  onPressed:
                      CacheCubit.get(context).cacheModel!.collectionIndex ==
                              index
                          ? () {
                              QuestionUICubit.get(context).initQuestion();
                              Get.to(() => const QuestionView(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: DelayManager.rightToLeft);
                            }
                          : null,
                  text: "المجموعة    ${index + 1}",
                ),
              ),
          separatorBuilder: (context, int index) => const SizedBox(height: 8.0),
          itemCount: GetGroupCubit.get(context).groupResponse!.groupsNo),
    );
  }
}
