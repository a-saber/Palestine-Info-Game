import 'question_group.dart';

class Sample {
  final List<QuestionGroup> sample;

  Sample({
    required this.sample,
  });

  factory Sample.fromJson(Map<String, dynamic> json) {
    var groupsFromJson = json['sample'] as List;
    List<QuestionGroup> groupList = groupsFromJson
        .map((groupJson) => QuestionGroup.fromJson(groupJson))
        .toList();

    return Sample(
      sample: groupList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sample': sample.map((group) => group.toJson()).toList(),
    };
  }
}
