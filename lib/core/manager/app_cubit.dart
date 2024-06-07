import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';

import '../local/cashe_helper.dart';
import '../models/models.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool? answered;
  List<CharModel?> value = [];
  bool suggest = false;
  bool remove = false;

// coins ***********
  Future addAdCoins() async {
    CacheHelperKeys.coinsNumber = CacheHelperKeys.coinsNumber! + 10;
    await CacheHelper.saveData(
        key: CacheHelperKeys.coinsKey, value: CacheHelperKeys.coinsNumber);
    emit(ChangeCoinsState());
  }

  Future addQuestionCoins() async {
    CacheHelperKeys.coinsNumber = CacheHelperKeys.coinsNumber! + 5;
    await CacheHelper.saveData(
        key: CacheHelperKeys.coinsKey, value: CacheHelperKeys.coinsNumber);
    emit(ChangeCoinsState());
  }

  Future deleteCoins() async {
    CacheHelperKeys.coinsNumber = CacheHelperKeys.coinsNumber! - 5;
    await CacheHelper.saveData(
        key: CacheHelperKeys.coinsKey, value: CacheHelperKeys.coinsNumber);
    emit(ChangeCoinsState());
  }

// END coins ***********

  // delete data
  void deleteQuestionData() {
    answered = null;
    value = [];
    suggest = false;
    remove = false;
    for (CharModel char in collections[CacheHelperKeys.collectionIndex!]
        .questions[CacheHelperKeys.questionIndex!]
        .characters) {
      char.isChosen = false;
    }
    emit(DeleteQuestionDataState());
  }
  // End delete data *******

  // sample on tap *********
  void sampleOnTap(int index) async {
    if (value.isEmpty) {
      value.add(collections[CacheHelperKeys.collectionIndex!]
          .questions[CacheHelperKeys.questionIndex!]
          .characters[index]);
      collections[CacheHelperKeys.collectionIndex!]
          .questions[CacheHelperKeys.questionIndex!]
          .characters[index]
          .isChosen = true;
      emit(SampleOnTapState());
    } else {
      whereToAdd(index);
      await checkEquality();
    }
  }

  void whereToAdd(int index) {
    for (int i = 0; i < value.length; i++) {
      if (value[i] == null) {
        value[i] = collections[CacheHelperKeys.collectionIndex!]
            .questions[CacheHelperKeys.questionIndex!]
            .characters[index];
        collections[CacheHelperKeys.collectionIndex!]
            .questions[CacheHelperKeys.questionIndex!]
            .characters[index]
            .isChosen = true;
        emit(SampleOnTapState());
        break;
      } else if (i + 1 == value.length &&
          value.length !=
              collections[CacheHelperKeys.collectionIndex!]
                  .questions[CacheHelperKeys.questionIndex!]
                  .answer
                  .length) {
        value.add(collections[CacheHelperKeys.collectionIndex!]
            .questions[CacheHelperKeys.questionIndex!]
            .characters[index]);
        collections[CacheHelperKeys.collectionIndex!]
            .questions[CacheHelperKeys.questionIndex!]
            .characters[index]
            .isChosen = true;
        emit(SampleOnTapState());
        break;
      }
    }
  }

  Future checkEquality() async {
    if (value.length ==
        collections[CacheHelperKeys.collectionIndex!]
            .questions[CacheHelperKeys.questionIndex!]
            .answer
            .length) {
      String answerText = "";
      bool check = true;
      for (int i = 0; i < value.length; i++) {
        if (value[i] != null) {
          answerText += value[i]!.char;
        } else {
          answered = null;
          check = false;
          break;
        }
      }
      if (check) {
        if (answerText ==
            collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .answer) {
          answered = true;
          emit(AnswerChangeBackgroundState());
          Future.delayed(const Duration(milliseconds: 300)).then((value) async {
            await afterAnsweredSuccess();
          });
        } else {
          answered = false;
          emit(AnswerChangeBackgroundState());
        }
      }
    }
  }

  Future afterAnsweredSuccess() async {
    emit(ShowContinueLevelUpState());
    // await levelUp();
  }

  Future levelUp() async {
    deleteQuestionData();
    await addQuestionCoins();
    if (CacheHelperKeys.questionIndex! + 1 ==
        collections[CacheHelperKeys.collectionIndex!].questions.length) {
      if (CacheHelperKeys.collectionIndex! + 1 == collections.length) {
        emit(GameDoneState());
      } else {
        CacheHelperKeys.collectionIndex = CacheHelperKeys.collectionIndex! + 1;
        await CacheHelper.saveData(
            key: CacheHelperKeys.collectionIndexKey,
            value: CacheHelperKeys.collectionIndex);
        CacheHelperKeys.questionIndex = 0;
        await CacheHelper.saveData(
            key: CacheHelperKeys.questionIndexKey,
            value: CacheHelperKeys.questionIndex);
        CacheHelperKeys.solvedNumber = 0;
        await CacheHelper.saveData(
            key: CacheHelperKeys.solvedKey,
            value: CacheHelperKeys.solvedNumber);
        emit(LevelDoneState());
      }
    } else {
      CacheHelperKeys.questionIndex = CacheHelperKeys.questionIndex! + 1;
      await CacheHelper.saveData(
          key: CacheHelperKeys.questionIndexKey,
          value: CacheHelperKeys.questionIndex);
      CacheHelperKeys.solvedNumber = CacheHelperKeys.solvedNumber! + 1;
      await CacheHelper.saveData(
          key: CacheHelperKeys.solvedKey, value: CacheHelperKeys.solvedNumber);
    }
  }

  // sample on tap End **********

  ///////////////

  void answerOnTab(int index) {
    print(index);
    print(value[index]!.id);
    collections[CacheHelperKeys.collectionIndex!]
        .questions[CacheHelperKeys.questionIndex!]
        .characters[value[index]!.id]
        .isChosen = false;
    value[index] = null;
    answered = null;
    emit(AnswerOnTapState());
  }

  void removeTwo() async {
    if (CacheHelperKeys.coinsNumber! < 5) {
      emit(ShowNotEnoughCoinsState());
    } else {
      await deleteCoins();
      for (int j = 0; j < 2; j++) {
        for (int i = 0;
            i <
                collections[CacheHelperKeys.collectionIndex!]
                    .questions[CacheHelperKeys.questionIndex!]
                    .characters
                    .length;
            i++) {
          if (!collections[CacheHelperKeys.collectionIndex!]
                  .questions[CacheHelperKeys.questionIndex!]
                  .answer
                  .contains(collections[CacheHelperKeys.collectionIndex!]
                      .questions[CacheHelperKeys.questionIndex!]
                      .characters[i]
                      .char) &&
              collections[CacheHelperKeys.collectionIndex!]
                      .questions[CacheHelperKeys.questionIndex!]
                      .characters[i]
                      .isChosen ==
                  false) {
            collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .characters[i]
                .isChosen = true;
            emit(SampleOnTapState());
            break;
          }
        }
      }
      remove = true;
      emit(RemoveTwoState());
    }
  }

  void suggestOne() async {
    if (CacheHelperKeys.coinsNumber! < 5) {
      emit(ShowNotEnoughCoinsState());
    } else {
      await deleteCoins();
      for (int i = 0;
          i <
              collections[CacheHelperKeys.collectionIndex!]
                  .questions[CacheHelperKeys.questionIndex!]
                  .characters
                  .length;
          i++) {
        if (collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .answer[0] ==
            collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .characters[i]
                .char) {
          if (value.isEmpty) {
            value.add(collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .characters[i]);
          } else {
            value[0] = collections[CacheHelperKeys.collectionIndex!]
                .questions[CacheHelperKeys.questionIndex!]
                .characters[i];
          }
          collections[CacheHelperKeys.collectionIndex!]
              .questions[CacheHelperKeys.questionIndex!]
              .characters[i]
              .isChosen = true;
          suggest = true;
          emit(SuggestOneState());
          break;
        }
      }
    }
  }

  void showRestartGameConfirm() async {
    print("nnnn");
    emit(ShowRestartState());
  }

  Future restartGame() async {
    await CacheHelper.saveData(key: CacheHelperKeys.questionIndexKey, value: 0);
    await CacheHelper.saveData(
        key: CacheHelperKeys.collectionIndexKey, value: 0);
    await CacheHelper.saveData(key: CacheHelperKeys.coinsKey, value: 0);
    await CacheHelper.saveData(key: CacheHelperKeys.solvedKey, value: 0);
    CacheHelperKeys.collectionIndex = 0;
    CacheHelperKeys.questionIndex = 0;
    CacheHelperKeys.coinsNumber = 0;
    CacheHelperKeys.solvedNumber = 0;
  }

  /*Future addQuestion({
  required String name,
  required String email,
  required String question,
  required String answer,
})async
  {
    emit(AddQuestionLoadingState());

    await FirebaseFirestore.instance
        .collection('questions')
        .add({
      "name":name ,
      "email": email,
      "question":question ,
      "answer": answer,
    }).then((value)  {
      emit(AddQuestionSuccessState());
    }).catchError((error)
    {
      emit(AddQuestionErrorState());
    });
  }*/

  List<CollectionModel> collections = [
    CollectionModel(title: "المجموعة 1", questions: [
      QuestionModel(
          text: 'ما اللذي يطلبه الناس اذا غاب عنهم واذا حضر هربوا منه',
          answer: 'المطر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/cat.jpeg',
          answer: 'قطة',
          characters: [
            CharModel(id: 0, char: 'ة'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما هو الشيء الذي ينبض بلا قلب',
          answer: 'الساعة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'س'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(text: 'طائر يلد … ولا يبيض', answer: 'الخفاش', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ش'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ف'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'ط'),
        CharModel(id: 10, char: 'ي'),
        CharModel(id: 11, char: 'خ'),
      ]),
      QuestionModel(
          text: 'من هو الذي ينام مرتديًا حذاءه لا يفارقه',
          answer: 'الحصان',
          characters: [
            CharModel(id: 0, char: 'ح'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 2", questions: [
      QuestionModel(
          text: 'شيء لا يبتل حتى ولو دخل الماء',
          answer: 'الضوء',
          characters: [
            CharModel(id: 0, char: 'و'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ض'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/cow.jpeg',
          answer: 'بقرة',
          characters: [
            CharModel(id: 0, char: 'أ'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'شيء تحمله وفي نفس الوقت يحملك',
          answer: 'الحذاء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ح'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ء'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما هو الشئ الذي يجب كسره قبل استخدامه',
          answer: 'البيضة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما هو الشئ الذي يمكن كسره دون ان نلمسه',
          answer: 'الوعد',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 3", questions: [
      QuestionModel(
          text: 'رجل خرج في المطر دون قبعة او مظلة ولم يبتل شعره لماذا',
          answer: 'أصلع',
          characters: [
            CharModel(id: 0, char: 'أ'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/7osan.jpeg',
          answer: 'حصان',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ح'),
            CharModel(id: 2, char: 'م'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: 'شئ قلبه ابيض ويرتدي قبعة خضراء لكن لونه اسود',
          answer: 'الباذنجان',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'ب'),
            CharModel(id: 3, char: 'ا'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ا'),
            CharModel(id: 9, char: 'ج'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: 'ما هو الملئ بالثقوب ومع ذلك يحتفظ بالماء',
          answer: 'السفنج',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ف'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'س'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ف'),
            CharModel(id: 9, char: 'ج'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: 'شي أمامك ولن تراه ',
          answer: 'المستقبل',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ق'),
            CharModel(id: 2, char: 'ل'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ت'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ب'),
            CharModel(id: 11, char: 'م'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 4", questions: [
      QuestionModel(
          text: 'تسمعه وتراه ولا يسمعك ولا يراك',
          answer: 'التلفاز',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ز'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ف'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ا'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ت'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ل'),
            CharModel(id: 11, char: 'ت'),
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/katkoot.jpeg',
          answer: 'كتكوت',
          characters: [
            CharModel(id: 0, char: 'ت'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ك'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'ا'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'و'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ت'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ك'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'هو ابن الماء . وإذا وضع فيه الماء مات',
          answer: 'الثلج',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ج'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ل'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما الذي يتقدم ولا يعود',
          answer: 'العمر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'م'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما الذي يمكن أن يملأ الغرفة ولكن لا يشغل مساحة',
          answer: 'الضوء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'و'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ء'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 5", questions: [
      QuestionModel(
          text: 'ملكك، ولكن جميع الناس تستخده دون إذن منك، فما هو؟',
          answer: 'اسمك',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/dog.jpeg',
          answer: 'كلب',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ب'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ر'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          text: 'شيء كلما أخذت مني جزءًا، إزداد حجمي أكثر',
          answer: 'الحفرة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'ف'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ح'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          text: 'أنا دائمًا ما أكون أمامك وحولك، ولكنك لا يمكن أن تراني',
          answer: 'الهواء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ء'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و')
          ]),
      QuestionModel(
          text: 'امتلك أسنان كثيرة ولكني لا أستطيع أن أقضم أو أعض',
          answer: 'مشط',
          characters: [
            CharModel(id: 0, char: 'ط'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ش'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
    ]),
    CollectionModel(title: "المجموعة 6", questions: [
      QuestionModel(
          text: 'أنا أستطيع أن أكتب، ولكني لا أستطيع القراءة',
          answer: 'قلم',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ق'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/mosmar.jpeg',
          answer: 'مسمار',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'م'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'خ'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          text: 'الكلمة التي عندما ننطقها فان معناها يصبح بلا قيمة',
          answer: 'السكوت',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ت'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و')
          ]),
      QuestionModel(
          text: 'الشيء الذي نقوم بذبحه بعد ذلك نقوم بالبكاء عليه',
          answer: 'بصل',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ص'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ب')
          ]),
      QuestionModel(
          text: 'هو الشيء الذي لا يدخل الا اذا قمت بضربه على رأسه',
          answer: 'مسمار',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'م'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
    ]),
    CollectionModel(title: "المجموعة 7", questions: [
      QuestionModel(
          text: 'تقوم بحرق نفسها من اجل ان يستفيد الغير',
          answer: 'شمعة',
          characters: [
            CharModel(id: 0, char: 'ش'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          isImage: true,
          text: 'assets/nemr.jpeg',
          answer: 'نمر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'ب'),
            CharModel(id: 5, char: 'د'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ر'),
            CharModel(id: 9, char: 'م'),
            CharModel(id: 10, char: 'ئ'),
            CharModel(id: 11, char: 'ر')
          ]),
      QuestionModel(
          text: 'الشخص الذي يحني له الامبراطور رأسه',
          answer: 'الحلاق',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'ل'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'ق'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ح'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ا')
          ]),
      QuestionModel(
          text: 'الشيئ الذي يسير بلا قدمين ويبكي دون ان يمتلك عينين',
          answer: 'سحابة',
          characters: [
            CharModel(id: 0, char: 'ح'),
            CharModel(id: 1, char: 'ء'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'س'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ب'),
            CharModel(id: 11, char: 'و')
          ]),
      QuestionModel(
          text: 'قدماه فوق الارض بينما رأسه فوق النجوم',
          answer: 'ضابط',
          characters: [
            CharModel(id: 0, char: 'ط'),
            CharModel(id: 1, char: 'ا'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ب'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ش'),
            CharModel(id: 10, char: 'ض'),
            CharModel(id: 11, char: 'ر')
          ]),
    ]),
    CollectionModel(title: "المجموعة 8", questions: [
      QuestionModel(text: 'شيئ يذهب دون ان يرجع ', answer: 'دخان', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ق'),
        CharModel(id: 2, char: 'غ'),
        CharModel(id: 3, char: 'ن'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'د'),
        CharModel(id: 6, char: 'ع'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'س'),
        CharModel(id: 10, char: 'ي'),
        CharModel(id: 11, char: 'خ')
      ]),
      QuestionModel(
          isImage: true,
          text: 'assets/shakoosh.jpeg',
          answer: 'شاكوش',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ش'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'خ'),
            CharModel(id: 4, char: 'و'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ش'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ك')
          ]),
      QuestionModel(
          text: 'له خمس أصابع دون لحم وعظم',
          answer: 'قفاز',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'ق'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ت'),
            CharModel(id: 5, char: 'ز'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ف'),
            CharModel(id: 11, char: 'و')
          ]),
      QuestionModel(
          text: 'أنا دائما جائع وسأموت إذا لم يطعموني، وأموت لو سقوني',
          answer: 'حريق',
          characters: [
            CharModel(id: 0, char: 'ر'),
            CharModel(id: 1, char: 'ح'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ق'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ب')
          ]),
      QuestionModel(
          text: 'لي رقبة وليس لدي رأس ولي ذراعين وليس لدي يدين',
          answer: 'قميص',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'م'),
            CharModel(id: 2, char: 'ق'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر')
          ]),
    ]),
    CollectionModel(title: "المجموعة 9", questions: [
      QuestionModel(
          text: 'يمر عبر المدن والحقول، ولكنه لا يتحرك',
          answer: 'طريق',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ق'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'أصغر دولة عربية من حيث المساحة',
          answer: 'البحرين',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ي'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ن'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ح'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'المدينة التي تسمى بمدينة الضباب',
          answer: 'لندن',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'د'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'س'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(text: 'الذهب الأسود ؟', answer: 'البترول', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ر'),
        CharModel(id: 2, char: 'ل'),
        CharModel(id: 3, char: 'ف'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'ط'),
        CharModel(id: 10, char: 'ب'),
        CharModel(id: 11, char: 'و'),
      ]),
      QuestionModel(
          text: 'أول بلد تشرع في الألعاب الأولمبية',
          answer: 'اليونان',
          characters: [
            CharModel(id: 0, char: 'ي'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 10", questions: [
      QuestionModel(
          text: 'الشئ الذي ليس له عين وله رأس',
          answer: 'دبوس',
          characters: [
            CharModel(id: 0, char: 'و'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ب'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'د'),
            CharModel(id: 11, char: 'س'),
          ]),
      QuestionModel(
          text: ' أول منتخب عربي صعد إلى كأس العالم',
          answer: 'مصر',
          characters: [
            CharModel(id: 0, char: 'أ'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'أشتريه بمالي ولا أدخله داري',
          answer: 'سيارة',
          characters: [
            CharModel(id: 0, char: 'ي'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ح'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'س'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ة'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'أذكى الكائنات البحرية',
          answer: 'دولفين',
          characters: [
            CharModel(id: 0, char: 'و'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ف'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ن'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'د'),
          ]),
      QuestionModel(
          text: 'السورة التي تقع في نصف القرآن',
          answer: 'الكهف',
          characters: [
            CharModel(id: 0, char: 'ف'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ك'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ه'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 11", questions: [
      QuestionModel(
          text: 'سورة من القرآن ذكرت فيها البسملة مرتين',
          answer: 'النمل',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'م'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'س'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ن'),
            CharModel(id: 11, char: 'ل'),
          ]),
      QuestionModel(
          text: ' السورة التي تعدل ثلث القرآن الكريم',
          answer: 'الإخلاص',
          characters: [
            CharModel(id: 0, char: 'إ'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ل'),
            CharModel(id: 4, char: 'ص'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'خ'),
            CharModel(id: 11, char: 'ا'),
          ]),
      QuestionModel(
          text: 'السورة التي بدأت وانتهت بالتسبيح',
          answer: 'الحشر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ل'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'ح'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ش'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'الحيوان الذي ارتبط اسمه بسيدنا صالح عليه السلام',
          answer: 'الناقة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ش'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ة'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: ' الأبن الأول لسيدنا آدم عليه السلام',
          answer: 'قابيل',
          characters: [
            CharModel(id: 0, char: 'ح'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 12", questions: [
      QuestionModel(
          text: 'السورة التي وردت فيها غزوة حنين',
          answer: 'التوبة',
          characters: [
            CharModel(id: 0, char: 'ت'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ض'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'و'),
          ]),
      QuestionModel(
          text: ' أقصر سورة في القرآن الكريم ',
          answer: 'الكوثر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ر'),
            CharModel(id: 3, char: 'ك'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ث'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و'),
          ]),
      QuestionModel(
          text: 'السورة التي تسببت في إسلام عمر بن الخطاب',
          answer: 'طه',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ط'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ء'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ه'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'أول عملة في تاريخ الدولة الإسلامية',
          answer: 'دينار',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'ر'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'د'),
          ]),
      QuestionModel(
          text: 'كم عدد أولي العزم من الرسل',
          answer: 'خمسة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'س'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'خ'),
            CharModel(id: 11, char: 'ة'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 13", questions: [
      QuestionModel(
          text: 'ما هو اسم العبد الصالح الذي رافقه نبي الله موسى عليه السلام',
          answer: 'الخضر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ض'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'خ'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما هي سورة بني إسرائيل',
          answer: 'الإسراء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'إ'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ا'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'اسم أطول نهر في العالم',
          answer: 'النيل',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ل'),
            CharModel(id: 2, char: 'ي'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'س'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ة'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: 'أكبر دولة في العالم من حيث المساحة',
          answer: 'روسيا',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ر'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ف'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'س'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و'),
          ]),
      QuestionModel(
          text: 'اسم العالم الذي قام باختراع المصباح الكهربي',
          answer: 'أديسون',
          characters: [
            CharModel(id: 0, char: 'ح'),
            CharModel(id: 1, char: 'و'),
            CharModel(id: 2, char: 'أ'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'س'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 14", questions: [
      QuestionModel(
          text: ' الشكل الذي تبدو عليه مجرة درب التبانة',
          answer: 'حلزوني',
          characters: [
            CharModel(id: 0, char: 'ز'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ل'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ض'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ي'),
            CharModel(id: 9, char: 'ن'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'و'),
          ]),
      QuestionModel(
          text: ' أكبر قارات العالم من حيث المساحة',
          answer: 'اسيا',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'عدد ألوان الطيف التي يتكون منها قوس قزح',
          answer: 'سبعة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ح'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'س'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ء'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ب'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'اسم اكبر بحيرة في العالم',
          answer: 'قزوين',
          characters: [
            CharModel(id: 0, char: 'و'),
            CharModel(id: 1, char: 'ي'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ن'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ز'),
          ]),
      QuestionModel(
          text: 'اسم اكبر خليج في العالم',
          answer: 'المكسيك',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ك'),
            CharModel(id: 2, char: 'م'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ك'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'س'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'و'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 15", questions: [
      QuestionModel(text: 'كم عدد عيون النحله ', answer: 'خمسة', characters: [
        CharModel(id: 0, char: 'ة'),
        CharModel(id: 1, char: 'خ'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ه'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ك'),
        CharModel(id: 7, char: 'م'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'ط'),
        CharModel(id: 10, char: 'ي'),
        CharModel(id: 11, char: 'س'),
      ]),
      QuestionModel(text: ' اسم بيت الدجاج', answer: 'قن', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ب'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ق'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'ن'),
        CharModel(id: 10, char: 'ي'),
        CharModel(id: 11, char: 'ر'),
      ]),
      QuestionModel(text: 'مقياس سرعة السفن', answer: 'العقده', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ب'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ع'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'س'),
        CharModel(id: 9, char: 'ق'),
        CharModel(id: 10, char: 'ه'),
        CharModel(id: 11, char: 'د'),
      ]),
      QuestionModel(
          text: 'الحيوان الذي يصاب بالحصبه كالانسان',
          answer: 'القرد',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'د'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ر'),
            CharModel(id: 11, char: 'خ'),
          ]),
      QuestionModel(
          text: 'أقوى الحيوانات ذاكره',
          answer: 'دولفين',
          characters: [
            CharModel(id: 0, char: 'ف'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ف'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'و'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'د'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 16", questions: [
      QuestionModel(
          text: 'آخر سورة نزلت فى القرآن',
          answer: 'النصر',
          characters: [
            CharModel(id: 0, char: 'ن'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ص'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'المدينه التى تسمي بمدينة الشمس',
          answer: 'بعلبك',
          characters: [
            CharModel(id: 0, char: 'ك'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ب'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ع'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(text: 'اضعف حواس الطيور', answer: 'الشم', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ب'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ش'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ء'),
        CharModel(id: 9, char: 'ط'),
        CharModel(id: 10, char: 'ء'),
        CharModel(id: 11, char: 'ر'),
      ]),
      QuestionModel(text: 'ما هو الشرك الاصغر', answer: 'الرياء', characters: [
        CharModel(id: 0, char: 'ا'),
        CharModel(id: 1, char: 'ب'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ق'),
        CharModel(id: 4, char: 'ء'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'ض'),
        CharModel(id: 10, char: 'ي'),
        CharModel(id: 11, char: 'ر'),
      ]),
      QuestionModel(text: 'المكون الرئيسي للزجاج', answer: 'رمل', characters: [
        CharModel(id: 0, char: 'ل'),
        CharModel(id: 1, char: 'ب'),
        CharModel(id: 2, char: 'ا'),
        CharModel(id: 3, char: 'ع'),
        CharModel(id: 4, char: 'م'),
        CharModel(id: 5, char: 'ذ'),
        CharModel(id: 6, char: 'ت'),
        CharModel(id: 7, char: 'ل'),
        CharModel(id: 8, char: 'ث'),
        CharModel(id: 9, char: 'د'),
        CharModel(id: 10, char: 'ر'),
        CharModel(id: 11, char: 'و'),
      ]),
    ]),
    CollectionModel(title: "المجموعة 17", questions: [
      QuestionModel(
          text: 'ما هو الذي يوجد في الليل ثلاثة مرات وفي النهار مرة واحدة؟',
          answer: 'اللام',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ل'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ك'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'لا'),
          ]),
      QuestionModel(
          text: 'له رأس واحدة وقدم واحدة وأربع أرجل؟',
          answer: 'السرير',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'س'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ر'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ج'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'يقف صديقان ويمشيان معًا، لاقيمة لأحدهما دون الآخر؟',
          answer: 'الحذاء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'و'),
            CharModel(id: 4, char: 'ه'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ا'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ح'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'حياً وينمو، لا يتنفس ولكنه يحتاج إلى الهواء؟',
          answer: 'الحريق',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ش'),
            CharModel(id: 2, char: 'ر'),
            CharModel(id: 3, char: 'ف'),
            CharModel(id: 4, char: 'ح'),
            CharModel(id: 5, char: 'ق'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ق'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'خ'),
          ]),
      QuestionModel(
          text:
              'سمعني الكثير، ولكن لم يراني أحد، ولن أتكلم مرة أخرى ما لم تتكلم',
          answer: 'الصدي',
          characters: [
            CharModel(id: 0, char: 'ح'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ص'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ص'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'د'),
            CharModel(id: 8, char: 'ن'),
            CharModel(id: 9, char: 'ا'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 18", questions: [
      QuestionModel(
          text: 'لي رقبة وليس لدي رأس ولي ذراعين وليس لدي يدين',
          answer: 'القميص',
          characters: [
            CharModel(id: 0, char: 'ف'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ق'),
            CharModel(id: 3, char: 'ا'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ص'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'لدي بحيرات بلا ماء، وجبال بلا أحجار، ومدن بلا مبان',
          answer: 'الخريطة',
          characters: [
            CharModel(id: 0, char: 'ل'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ة'),
            CharModel(id: 5, char: 'ف'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'خ'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما الذي يمر عبر المدن والحقول، ولكنه لا يتحرك؟',
          answer: 'الطريق',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ح'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ي'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ق'),
            CharModel(id: 9, char: 'ط'),
            CharModel(id: 10, char: 'ء'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما الذي يمكن أن يملأ الغرفة ولكن لا يشغل مساحة؟',
          answer: 'الضوء',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ق'),
            CharModel(id: 4, char: 'ء'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'و'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما الذي يتقدم ولا يعود؟',
          answer: 'العمر',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ب'),
            CharModel(id: 2, char: 'ا'),
            CharModel(id: 3, char: 'ع'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ت'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'د'),
            CharModel(id: 10, char: 'ر'),
            CharModel(id: 11, char: 'و'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 19", questions: [
      QuestionModel(
          text: 'أنا دائما جائع وسأموت إذا لم يطعموني، وأموت لو سقوني',
          answer: 'الحريق',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ح'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ق'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'أي شهر من السنة به 28 يومًا؟ ',
          answer: 'كلهم',
          characters: [
            CharModel(id: 0, char: 'ك'),
            CharModel(id: 1, char: 'س'),
            CharModel(id: 2, char: 'م'),
            CharModel(id: 3, char: 'ف'),
            CharModel(id: 4, char: 'ل'),
            CharModel(id: 5, char: 'ه'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ن'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'م'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ج'),
          ]),
      QuestionModel(
          text: 'شيئ يذهب دون ان يرجع ، ما هو هذا الشيئ ؟',
          answer: 'الدخان',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ن'),
            CharModel(id: 2, char: 'خ'),
            CharModel(id: 3, char: 'د'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ل'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ا'),
            CharModel(id: 9, char: 'ج'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ن'),
          ]),
      QuestionModel(
          text: 'قدماه فوق الارض بينما رأسه فوق النجوم ، فمن يكون ؟',
          answer: 'الضابط',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ض'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ا'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ط'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ف'),
            CharModel(id: 9, char: 'ج'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ب'),
          ]),
      QuestionModel(
          text: 'ما هو الشيئ الذي يسير بلا قدمين ويبكي دون ان يمتلك عينين ؟ ',
          answer: 'السحاب',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ق'),
            CharModel(id: 2, char: 'ل'),
            CharModel(id: 3, char: 'ح'),
            CharModel(id: 4, char: 'ت'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ا'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'س'),
            CharModel(id: 10, char: 'ب'),
            CharModel(id: 11, char: 'م'),
          ]),
    ]),
    CollectionModel(title: "المجموعة 20", questions: [
      QuestionModel(
          text: ' له خمس أصابع دون لحم وعظم، ما هذا ؟',
          answer: 'القفاز',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ق'),
            CharModel(id: 2, char: 'ز'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ف'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'ا'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ت'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ل'),
            CharModel(id: 11, char: 'ت'),
          ]),
      QuestionModel(
          text: ' ما ذلك الشئ الذي يحيا أول الشهر ويموت أخره ',
          answer: 'القمر',
          characters: [
            CharModel(id: 0, char: 'ق'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ة'),
            CharModel(id: 4, char: 'ا'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'م'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ب'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'ما هي الكلمة التي عندما ننطقها فان معناها يصبح بلا قيمة ؟',
          answer: 'السكوت',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'س'),
            CharModel(id: 2, char: 'ج'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'ك'),
            CharModel(id: 5, char: 'ذ'),
            CharModel(id: 6, char: 'و'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ت'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'ل'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: 'لا امتلك بداية وليس لي نهاية ، فمن اكون ؟',
          answer: 'الدائرة',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'د'),
            CharModel(id: 2, char: 'غ'),
            CharModel(id: 3, char: 'ا'),
            CharModel(id: 4, char: 'م'),
            CharModel(id: 5, char: 'ئ'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ة'),
            CharModel(id: 9, char: 'ص'),
            CharModel(id: 10, char: 'م'),
            CharModel(id: 11, char: 'ر'),
          ]),
      QuestionModel(
          text: ' أنا أستطيع أن أكتب، ولكني لا أستطيع القراءة، فمن أكون؟',
          answer: 'القلم',
          characters: [
            CharModel(id: 0, char: 'ا'),
            CharModel(id: 1, char: 'ع'),
            CharModel(id: 2, char: 'ق'),
            CharModel(id: 3, char: 'ه'),
            CharModel(id: 4, char: 'و'),
            CharModel(id: 5, char: 'م'),
            CharModel(id: 6, char: 'ع'),
            CharModel(id: 7, char: 'ل'),
            CharModel(id: 8, char: 'ث'),
            CharModel(id: 9, char: 'ض'),
            CharModel(id: 10, char: 'ي'),
            CharModel(id: 11, char: 'ء'),
          ]),
    ]),
  ];
}
