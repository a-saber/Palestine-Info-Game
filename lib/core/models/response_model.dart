import 'package:word_game/core/models/question_group.dart';
import 'package:word_game/features/groups/presentation/cubit/get_group_cubit/get_group_state.dart';

class GroupResponse {
  final int groupsNo;
  final int groupsTotalNo;
  final QuestionGroup? group;
  final GetGroupState getGroupState;

  GroupResponse({
    required this.groupsNo,
    required this.groupsTotalNo,
    required this.group,
    required this.getGroupState,
  });
}
