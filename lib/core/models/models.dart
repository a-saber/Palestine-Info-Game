class CollectionModel
{
  String title;
  int solved=0;
  List<QuestionModel> questions =[];

  CollectionModel({required this.title, required this.questions});
}

class QuestionModel {
  String text;
  String answer;
  List<CharModel> characters = [];
  bool solved;
  bool isImage;


  QuestionModel({
    required this.text,
    required this.answer,
    required this.characters,
    this.solved = false,
    this.isImage = false
  });
}

class CharModel
{
  String char;
  bool isChosen;
  int id;

  CharModel({required this.id, required this.char, this.isChosen=false});
}