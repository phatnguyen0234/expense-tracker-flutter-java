import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../features/transactions/models/transaction.dart';
import '../../features/transactions/services/transaction_service.dart';
import '../../core/api/dio_client.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late TransactionService _transactionService;
  List<Transaction> _allTransactions = [];
  bool _isLoading = false;

  double _totalIncome = 0;
  double _totalExpense = 0;
  Map<String, double> _expenseByCategory = {};
  Map<String, double> _incomeByCategory = {};

  @override
  void initState() {
    super.initState();
    _transactionService = TransactionService(DioClient.dio);
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      // Load all transactions
      final transactions = await _transactionService.getTransactions();
      setState(() {
        _allTransactions = transactions;
      });

      // Calculate totals and group by category
      _calculateStats();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi tải dữ liệu: $e')));
      }
    }
    setState(() => _isLoading = false);
  }

  void _calculateStats() {
    _totalIncome = 0;
    _totalExpense = 0;
    _expenseByCategory = {};
    _incomeByCategory = {};

    for (var tx in _allTransactions) {
      if (tx.type == 'INCOME') {
        _totalIncome += tx.amount;
        _incomeByCategory[tx.categoryName] =
            (_incomeByCategory[tx.categoryName] ?? 0) + tx.amount;
      } else {
        _totalExpense += tx.amount;
        _expenseByCategory[tx.categoryName] =
            (_expenseByCategory[tx.categoryName] ?? 0) + tx.amount;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Summary Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Thu nhập',
                              amount: _totalIncome,
                              color: Colors.green,
                              icon: Icons.arrow_upward,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Chi tiêu',
                              amount: _totalExpense,
                              color: Colors.red,
                              icon: Icons.arrow_downward,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryCard(
                        title: 'Cân bằng',
                        amount: _totalIncome - _totalExpense,
                        color: (_totalIncome - _totalExpense) >= 0
                            ? Colors.blue
                            : Colors.orange,
                        icon: Icons.account_balance_wallet,
                      ),
                      const SizedBox(height: 24),

                      /// Category Breakdown
                      if (_expenseByCategory.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Chi tiêu theo danh mục',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ..._expenseByCategory.entries.map((entry) {
                              final percentage =
                                  (_totalExpense > 0)
                                      ? (entry.value / _totalExpense * 100)
                                      : 0.0;
                              return _buildCategoryBar(
                                name: entry.key,
                                amount: entry.value,
                                percentage: percentage,
                                color: Colors.red,
                              );
                            }).toList(),
                          ],
                        ),
                      const SizedBox(height: 24),

                      if (_incomeByCategory.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Thu nhập theo danh mục',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ..._incomeByCategory.entries.map((entry) {
                              final percentage =
                                  (_totalIncome > 0)
                                      ? (entry.value / _totalIncome * 100)
                                      : 0.0;
                              return _buildCategoryBar(
                                name: entry.key,
                                amount: entry.value,
                                percentage: percentage,
                                color: Colors.green,
                              );
                            }).toList(),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(icon, color: color),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${amount.toStringAsFixed(0)}đ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBar({
    required String name,
    required double amount,
    required double percentage,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${amount.toStringAsFixed(0)}đ (${percentage.toStringAsFixed(1)}%)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}



