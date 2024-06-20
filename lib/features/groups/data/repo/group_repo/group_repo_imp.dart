import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:word_game/core/father_repo/father_repo.dart';
import 'package:word_game/core/models/question_group.dart';
import 'package:word_game/core/models/response_model.dart';
import 'package:word_game/features/groups/data/repo/group_repo/group_repo.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_state.dart';

class GroupRepoImp extends GroupRepo {
  @override
  Future<Either<String, GroupResponse?>> getGroup() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/questions/questions.json');

      // Parse the JSON string
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      GetGroupState getGroupState;
      Map<String, dynamic>? groupData;
      if (FatherRepo.cacheModel!.collectionIndex >= jsonMap['sample'].length) {
        getGroupState = GetGroupAllDoneState();
      } else {
        getGroupState = GetGroupSuccessState();
        groupData = jsonMap['sample'][FatherRepo.cacheModel!.collectionIndex];
      }

      FatherRepo.groupResponse = GroupResponse(
          groupsNo: jsonMap['sample'].length,
          groupsTotalNo: jsonMap['sample'].length,
          group: groupData == null ? null : QuestionGroup.fromJson(groupData),
          getGroupState: getGroupState);

      return right(FatherRepo.groupResponse);
    } catch (e) {
      print(e.toString());
      return left('Sorry, There is an error please try again later');
    }
  }
}
