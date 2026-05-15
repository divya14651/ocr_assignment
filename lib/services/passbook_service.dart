
import 'package:ocr_assignment/model/passbook_model.dart';

class PassbookParserService {

  static PassbookResult parse(String text) {

    final lines = text
        .replaceAll(RegExp(r'\s+'), ' ')
        .split('\n');

    String account = "";
    String ifsc = "";
    String bank = "";
    String branch = "";

    List<Transaction> transactions = [];

    final ifscRegex = RegExp(r'[A-Z]{4}0[A-Z0-9]{6}');
    final accRegex = RegExp(r'\d{9,18}');

    final transactionRegex = RegExp(
        r'(\d{1,2}[/-]\d{1,2}[/-]\d{2,4})\s+(.+?)\s+(-?\(?\d+(?:\.\d+)?\)?)\s+(-?\(?\d+(?:\.\d+)?\)?)?'
    );

    for (var line in lines) {

      final l = line.toLowerCase();

      if (l.contains("bank") && bank.isEmpty) {
        bank = line.trim();
      }

      if (l.contains("branch")) {
        branch = line.trim();
      }

      final ifscMatch = ifscRegex.firstMatch(line.toUpperCase());
      if (ifscMatch != null) {
        ifsc = ifscMatch.group(0) ?? "";
      }

      final accMatch = accRegex.firstMatch(line);
      if (accMatch != null && account.isEmpty) {
        account = accMatch.group(0) ?? "";
      }

      final match = transactionRegex.firstMatch(line);

      if (match != null) {
        transactions.add(Transaction(
          date: match.group(1) ?? "",
          description: match.group(2)?.trim() ?? "",
          amount: match.group(3) ?? "",
          balance: match.group(4) ?? "",
        ));
      }
    }

    return PassbookResult(
      header: PassbookHeader(
        accountNumber: account,
        ifsc: ifsc,
        bankName: bank,
        branchName: branch,
      ),
      transactions: transactions,
    );
  }
}