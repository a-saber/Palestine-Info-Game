import 'package:flutter/material.dart';
import 'package:word_game/core/core_widget/default_appbar.dart';
import 'package:word_game/features/question/presentation/views/widgets/question_view_body.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(),
      body: SafeArea(child: QuestionViewBody()),
    );
  }
}
