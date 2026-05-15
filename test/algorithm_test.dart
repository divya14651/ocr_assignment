import 'package:flutter_test/flutter_test.dart';
import 'package:ocr_assignment/services/card_parser_service.dart';
import 'package:ocr_assignment/services/passbook_service.dart';
import 'package:ocr_assignment/services/luhn_service.dart';

void main() {

  group('Card Scanner Tests', () {

    test('Luhn Algorithm Validation Test', () {
      expect(LuhnService.isValid("4111111111111111"), true);
      expect(LuhnService.isValid("4111111111111112"), false);
    });

    test('Card Regex Parsing Test', () {
      String mockOCRText =
          "VISA\n4111 1111 1111 1111\n05/28\nRAHUL SHARMA";

      final result = CardParserService.parseCard(mockOCRText);

      expect(result.cardNumber, "4111111111111111");
      expect(result.expiryDate.isNotEmpty, true);
      expect(result.isValid, true);
    });
  });

  group('Passbook Scanner Tests', () {

    test('IFSC and Account Number Extraction', () {
      String mockPassbookText =
          "STATE BANK OF INDIA\nIFSC: SBIN0001234\nA/C No: 123456789012\nBhopal Branch";

      final result = PassbookParserService.parse(mockPassbookText);

      expect(result.header.ifsc.contains("SBIN0001234"), true);
      expect(result.header.accountNumber.isNotEmpty, true);
    });

    test('Transaction detection test', () {
      String mockPassbookText =
          "01/01/2024 Salary 5000 15000";

      final result = PassbookParserService.parse(mockPassbookText);

      expect(result.transactions.isNotEmpty, true);
    });
  });
}