import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:word_game/core/local/cache_helper_keys.dart';
import 'package:word_game/core/models/question_group.dart';
import 'package:word_game/features/home/data/repo/home_repo/home_repo.dart';

//CacheHelperKeys.collectionIndex

class HomeRepoImp extends HomeRepo {
  @override
  Future<Either<String, QuestionGroup?>> getGroup() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/questions/questions.json');

      // Parse the JSON string
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Get current group
      Map<String, dynamic> groupData =
          jsonMap['sample'][CacheHelperKeys.collectionIndex];

      // Convert the parsed JSON to a Sample object
      QuestionGroup questionGroup = QuestionGroup.fromJson(groupData);

      return right(questionGroup);
    } catch (e) {
      return left('Sorry, There is an error please try again later');
    }
  }
}
