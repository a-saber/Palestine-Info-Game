class Question {
  final String questionId;
  final String text;
  final bool isImage;
  final String? image;
  final List<String> answer;
  final List<String> charSample;

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
      charSample: List<String>.from(json['char_sample']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'text': text,
      'is_image': isImage,
      'image': image,
      'answer': answer,
      'char_sample': charSample,
    };
  }
}
