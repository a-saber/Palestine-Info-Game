import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';

import '../../../../../core/manager/app_cubit.dart';
import '../../../../../core/manager/app_states.dart';
import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';
import 'custom_square.dart';

class AnswerChecker extends StatelessWidget {
  const AnswerChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: AppCubit.get(context).answered == null
                      ? ColorsManager.grey
                      : AppCubit.get(context).answered!
                          ? ColorsManager.green
                          : ColorsManager.red,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 35,
                  child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: AppCubit.get(context)
                          .collections[CacheHelperKeys.collectionIndex!]
                          .questions[CacheHelperKeys.questionIndex!]
                          .answer
                          .length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap:
                                    index >= AppCubit.get(context).value.length
                                        ? null
                                        : () {
                                            AppCubit.get(context)
                                                .answerOnTab(index);
                                          },
                                child: index >=
                                        AppCubit.get(context).value.length
                                    ? CustomSquare(
                                        squareStatus: SquareStatus.answerEmpty)
                                    : AppCubit.get(context).value[index] == null
                                        ? CustomSquare(
                                            squareStatus:
                                                SquareStatus.answerEmpty)
                                        : CustomSquare(
                                            squareStatus:
                                                SquareStatus.answerFull,
                                            text: AppCubit.get(context)
                                                .value[index]!
                                                .char,
                                          )),
                            const SizedBox(
                              width: 5.0,
                            )
                          ],
                        );
                      }),
                ),
              )
            ],
          );
        },
        listener: (context, state) {});
  }
}
