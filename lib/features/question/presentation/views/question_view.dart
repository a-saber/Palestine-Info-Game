import 'package:flutter/material.dart';
import 'package:word_game/features/question/presentation/views/widgets/appbar_action.dart';
import 'package:word_game/features/question/presentation/views/widgets/appbar_leading.dart';
import 'package:word_game/features/question/presentation/views/widgets/appbar_title.dart';
import 'package:word_game/features/question/presentation/views/widgets/question_view_body.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading: const AppbarLeading(),
        centerTitle: true,
        title: const AppbarTitle(),
        actions: const [
          AppbarAction(),
        ],
        elevation: 0,
      ),
      body: const SafeArea(child: QuestionViewBody()),
      /*bottomNavigationBar: bannerAd == null ?
      Container():
      SizedBox(
        height: 52.0,
        child: AdWidget(ad: bannerAd!,),
      ),*/
    );
  }
}
