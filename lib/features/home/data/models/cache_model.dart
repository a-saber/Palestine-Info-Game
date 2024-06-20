class CacheModel {
  int collectionIndex;
  int questionIndex;
  int coinsNumber;
  int solvedNumber;
  bool editMinus;

  CacheModel(
      {required this.coinsNumber,
      this.editMinus = false,
      required this.collectionIndex,
      required this.questionIndex,
      required this.solvedNumber});
}
