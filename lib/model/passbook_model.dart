class Transaction {
  final String date;
  final String description;
  final String amount;
  final String balance;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.balance,
  });

  Map<String, dynamic> toJson() => {
    "date": date,
    "description": description,
    "amount": amount,
    "balance": balance,
  };

  @override
  String toString() {
    return 'Transaction(date: $date, desc: $description, amount: $amount, balance: $balance)';
  }
}


class PassbookHeader {
  final String accountNumber;
  final String ifsc;
  final String bankName;
  final String branchName;

  PassbookHeader({
    required this.accountNumber,
    required this.ifsc,
    required this.bankName,
    required this.branchName,
  });

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "ifsc": ifsc,
    "bankName": bankName,
    "branchName": branchName,
  };

  @override
  String toString() {
    return 'PassbookHeader(account: $accountNumber, ifsc: $ifsc, bank: $bankName, branch: $branchName)';
  }
}

class PassbookResult {
  final PassbookHeader header;
  final List<Transaction> transactions;

  PassbookResult({
    required this.header,
    required this.transactions,
  });

  bool get isValid => transactions.isNotEmpty;

  @override
  String toString() {
    return 'PassbookResult(header: $header, transactions: ${transactions.length})';
  }
}

