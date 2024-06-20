import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/core_widget/alerts/alert_game_done.dart';
import 'package:word_game/core/core_widget/alerts/alert_level_done.dart';
import 'package:word_game/core/core_widget/alerts/alert_question_done.dart';
import 'package:word_game/core/father_repo/father_repo.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_state.dart';
import 'package:word_game/features/question/presentation/views/widgets/sample.dart';

import 'answer_checker.dart';

class Answer extends StatelessWidget {
  const Answer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QueUpCubit, QueUpState>(
        listener: (context, state) {
          if (state is QueLevelUpSuccessState) {
            GetGroupCubit.get(context).getCurrentGroup();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => alertLevelDone(context));
          } else if (state is QueGameDoneSuccessState) {
            GetGroupCubit.get(context).getCurrentGroup();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => alertGameDone(context));
          } else if (state is QueUpSuccessState) {
            showDialog(
              context: context,
              builder: (BuildContext ctx) => alertQuestionDone(context),
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) => const Column(
              children: [
                AnswerChecker(),
                //SizedBox(height: 5,),
                Sample()
              ],
            ));
  }
}
