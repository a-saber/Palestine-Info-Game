class CharModel {
  int id;
  String char;
  bool isChosen;
  bool isDeleted;

  CharModel(
      {required this.id,
      required this.char,
      this.isChosen = false,
      this.isDeleted = false});
}
