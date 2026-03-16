import 'package:dio/dio.dart';
import '../models/transaction.dart';

class TransactionService {
  final Dio _dio;

  TransactionService(this._dio);

  Future<List<Transaction>> getTransactions({
    String? month,
    String? type,
  }) async {
    try {
      final response = await _dio.get(
        '/transactions',
        queryParameters: {
          if (month != null) 'month': month,
          if (type != null) 'type': type,
        },
      );
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    try {
      final response = await _dio.post(
        '/transactions',
        data: transaction.toJson(),
      );
      return Transaction.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    try {
      final response = await _dio.put(
        '/transactions/${transaction.id}',
        data: transaction.toJson(),
      );
      return Transaction.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await _dio.delete('/transactions/$id');
    } catch (e) {
      rethrow;
    }
  }
}
