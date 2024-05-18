class CardModel {
  final String imagePath;
  final int id;
  bool isFlipped;
  bool isMatched;

  CardModel({required this.imagePath, required this.id, this.isFlipped = false, this.isMatched = false});
}

