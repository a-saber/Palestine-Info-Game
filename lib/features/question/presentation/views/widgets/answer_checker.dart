import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/features/question/data/models/que_up_response.dart';
import 'package:word_game/features/question/presentation/cubit/edit_coins_cubit/edit_coins_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/que_up_cubit/que_up_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_cubit.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_state.dart';
import '../../../../../core/resources_manager/colors_manager.dart';
import '../../../../../core/resources_manager/constant_manager.dart';
import 'custom_square.dart';

class AnswerChecker extends StatelessWidget {
  const AnswerChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionUICubit, QuestionUIState>(
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
              color: QuestionUICubit.get(context).correctAnswer == null
                  ? ColorsManager.grey
                  : QuestionUICubit.get(context).correctAnswer!
                      ? ColorsManager.green
                      : ColorsManager.red,
            ),
          ),
          Center(
            child: SizedBox(
              height: 35,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      QuestionUICubit.get(context).question!.answer.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: index >=
                                    QuestionUICubit.get(context)
                                        .userInput
                                        .length
                                ? null
                                : () {
                                    QuestionUICubit.get(context)
                                        .answerOnTab(indexInAnswer: index);
                                  },
                            child: index >=
                                    QuestionUICubit.get(context)
                                        .userInput
                                        .length
                                ? const CustomSquare(
                                    squareStatus: SquareStatus.answerEmpty)
                                : QuestionUICubit.get(context)
                                            .userInput[index] ==
                                        null
                                    ? const CustomSquare(
                                        squareStatus: SquareStatus.answerEmpty)
                                    : CustomSquare(
                                        squareStatus: SquareStatus.answerFull,
                                        text: QuestionUICubit.get(context)
                                            .userInput[index]!
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
    }, listener: (context, state) async {
      if (state is AnswerSuccessState) {
        await QueUpCubit.get(context).questionUp();
        await EditCoinsCubit.get(context)
            .editCoins(editCoinsType: EditCoinsType.question);
      }
    });
  }
}
