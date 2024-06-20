import 'question.dart';

class QuestionGroup {
  final int groupId;
  final List<Question> questions;

  QuestionGroup({
    required this.groupId,
    required this.questions,
  });

  factory QuestionGroup.fromJson(Map<String, dynamic> json) {
    var questionsFromJson = json['questions'] as List;
    List<Question> questionList = questionsFromJson
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();

    return QuestionGroup(
      groupId: json['group_id'],
      questions: questionList,
    );
  }
}
