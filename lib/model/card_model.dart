class CardModel {
  final String imagePath;
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final bool isValid;

  CardModel({
    required this.imagePath,
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.isValid,
  });
}