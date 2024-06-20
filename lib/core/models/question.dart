import 'package:word_game/core/models/char_model.dart';

class Question {
  final int questionId;
  final String text;
  final bool isImage;
  final String? image;
  final List<String> answer;
  final List<CharModel> charSample;

  Question({
    required this.questionId,
    required this.text,
    required this.isImage,
    required this.image,
    required this.answer,
    required this.charSample,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionId: json['question_id'],
        text: json['text'],
        isImage: json['is_image'],
        image: json['image'],
        answer: List<String>.from(json['answer']),
        charSample: List.generate(json['char_sample'].length,
            (index) => CharModel(id: index, char: json['char_sample'][index])));
  }
}
