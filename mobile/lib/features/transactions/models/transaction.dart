class Transaction {
  final int? id;
  final int categoryId;
  final String categoryName;
  final double amount;
  final String type; // 'INCOME' hoặc 'EXPENSE'
  final DateTime txnDate;
  final String? note;
  final String? paymentMethod; // 'CASH', 'BANK', 'EWALLET', 'OTHER'
  final int? userId;
  final String? userName;

  Transaction({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.type,
    required this.txnDate,
    this.note,
    this.paymentMethod,
    this.userId,
    this.userName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? 'EXPENSE',
      txnDate: DateTime.parse(json['txnDate']),
      note: json['note'],
      paymentMethod: json['paymentMethod'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'amount': amount,
      'type': type,
      'txnDate': txnDate.toIso8601String(),
      'note': note,
      'paymentMethod': paymentMethod ?? 'CASH',
    };
  }
}
