import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/father_repo/father_repo.dart';
import 'package:word_game/core/models/char_model.dart';
import 'package:word_game/core/models/question.dart';
import 'package:word_game/features/question/presentation/cubit/question_ui_cubit/question_ui_state.dart';

class QuestionUICubit extends Cubit<QuestionUIState> {
  QuestionUICubit() : super(QuestionInitialState());
  static QuestionUICubit get(context) => BlocProvider.of(context);

  bool? correctAnswer;
  List<CharModel?> userInput = [];
  Question? question;
  void initQuestion() {
    for (int i = 0;
        i <
            FatherRepo
                .groupResponse!
                .group!
                .questions[FatherRepo.cacheModel!.questionIndex]
                .charSample
                .length;
        i++) {
      FatherRepo
          .groupResponse!
          .group!
          .questions[FatherRepo.cacheModel!.questionIndex]
          .charSample[i]
          .isChosen = false;
      FatherRepo
          .groupResponse!
          .group!
          .questions[FatherRepo.cacheModel!.questionIndex]
          .charSample[i]
          .isDeleted = false;
    }
    question = FatherRepo
        .groupResponse!.group!.questions[FatherRepo.cacheModel!.questionIndex];
    correctAnswer = null;
    userInput =
        List<CharModel?>.generate(question!.answer.length, (index) => null);
    emit(NewQuestionState());
  }

  void sampleOnTap({required int indexInSample}) async {
    if (userInput.isEmpty) {
      userInput.add(question!.charSample[indexInSample]);
      question!.charSample[indexInSample].isChosen = true;
      emit(SampleTabbedState());
    } else {
      whereToAdd(indexInSample: indexInSample);
      await checkEquality();
    }
  }

  void whereToAdd({required int indexInSample}) {
    for (int i = 0; i < question!.answer.length; i++) {
      if (userInput[i] == null) {
        userInput[i] = question!.charSample[indexInSample];
        question!.charSample[indexInSample].isChosen = true;
        emit(SampleTabbedState());
        break;
      }
    }
  }

  Future checkEquality() async {
    if (userInput.contains(null)) {
      correctAnswer = null;
    } else if (userInput.length == question!.answer.length) {
      List<String> answer = List<String>.generate(userInput.length,
          (index) => userInput[index] == null ? '' : userInput[index]!.char);
      if (answer.toString() == question!.answer.toString()) {
        correctAnswer = true;
        emit(AnswerSuccessState());
      } else {
        correctAnswer = false;
        emit(AnswerErrorState());
      }
    }
  }

  void answerOnTab({required int indexInAnswer}) {
    question!.charSample[userInput[indexInAnswer]!.id].isChosen = false;
    userInput[indexInAnswer] = null;
    correctAnswer = null;
    emit(AnswerTabbedState());
  }

  int findCharInSample(String char) {
    for (var element in question!.charSample) {
      if (element.char == char) {
        return element.id;
      }
    }
    return 0;
  }

  void suggest({required int coinsNo}) {
    if (coinsNo < 5) {
      emit(SuggestErrorState());
      return;
    } else {
      if (!userInput.contains(null)) {
        String lastChar = question!.answer.last;
        int index = findCharInSample(lastChar);
        CharModel charModel = CharModel(id: index, char: lastChar);
        userInput.removeLast();
        userInput.add(charModel);
        question!.charSample[index].isChosen = true;
      } else {
        for (int i = 0; i < userInput.length; i++) {
          if (userInput[i] == null) {
            String targetChar = question!.answer.elementAt(i);
            int indexInSample = findCharInSample(targetChar);
            userInput[i] = question!.charSample[indexInSample];
            question!.charSample[indexInSample].isChosen = true;
            break;
          }
        }
      }
      emit(SuggestState());
      checkEquality();
    }
  }

  void delete({required int coinsNo}) {
    if (coinsNo < 5) {
      emit(DeleteErrorState());
      return;
    } else {
      for (int i = 0; i < question!.charSample.length; i++) {
        print('object');
        print(question!.charSample[i].char);
        if (!question!.answer.contains(question!.charSample[i].char) &&
            !question!.charSample[i].isDeleted) {
          print('object1');
          question!.charSample[i].isDeleted = true;
          question!.charSample[i].isChosen = false;
          if (userInput.contains(question!.charSample[i])) {
            userInput.remove(question!.charSample[i]);
          }

          break;
        }
      }
      emit(DeleteState());
    }
  }
}
