import 'package:flutter/material.dart';
import 'package:word_game/features/question/presentation/views/widgets/sample.dart';


import 'answer_checker.dart';


class Answer extends StatelessWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children:const
      [
         AnswerChecker(),
        //SizedBox(height: 5,),
        Sample()
      ],
    );
  }
}