import 'package:ocr_assignment/model/card_model.dart';
import 'package:ocr_assignment/services/luhn_service.dart';

class CardParserService {

  static CardModel parseCard(String rawText) {

    String cleanText = rawText
        .toUpperCase()
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'[^\dA-Z\s/]'), ' ')
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll(RegExp(r'\s+'), ' ');

    RegExp cardRegex = RegExp(r'\d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4,6}');

    String? rawCard = cardRegex.firstMatch(cleanText)?.group(0);

    String fullNumber =
        rawCard?.replaceAll(RegExp(r'[\s-]'), '') ?? "";
    RegExp expiryRegex =
    RegExp(r'(0[1-9]|1[0-2])\s*[\/\-]?\s*([0-9]{2,4})');

    String expiry =
        expiryRegex.firstMatch(cleanText)?.group(0) ?? "";
    bool isValid = false;

    if (fullNumber.length >= 13 && fullNumber.length <= 19) {
      isValid = LuhnService.isValid(fullNumber);
    }

    return CardModel(
      imagePath: "",
      cardNumber: fullNumber,
      expiryDate: expiry,
      isValid: isValid,
      holderName: _extractName(cleanText),
    );
  }

  static String _extractName(String text) {

    List<String> lines = text.split(' ');

    for (String line in lines) {
      String cleaned = line.trim();

      if (cleaned.length >= 5 &&
          RegExp(r'^[A-Z ]+$').hasMatch(cleaned) &&
          !cleaned.contains("VISA") &&
          !cleaned.contains("MASTER") &&
          !cleaned.contains("DEBIT") &&
          !cleaned.contains("CREDIT") &&
          !RegExp(r'\d').hasMatch(cleaned)) {
        return cleaned;
      }
    }

    return "Not Found";
  }
}