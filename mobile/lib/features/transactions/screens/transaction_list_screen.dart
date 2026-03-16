import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../services/transaction_service.dart';
import '../services/category_service.dart';
import '../../../core/api/dio_client.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late TransactionService _service;
  late CategoryService _categoryService;
  List<Transaction> _transactions = [];
  List<Category> _categories = [];
  String? _selectedMonth;
  String? _selectedType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _service = TransactionService(DioClient.dio);
    _categoryService = CategoryService(DioClient.dio);
    _loadTransactions();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _categoryService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      if (mounted) {
        print('Lỗi tải danh mục: $e');
      }
    }
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    try {
      final transactions = await _service.getTransactions(
        month: _selectedMonth,
        type: _selectedType,
      );
      setState(() {
        _transactions = transactions;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao dịch', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Column(
          children: [
            /// FILTER SECTION
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)],
                      ),
                      child: DropdownButton<String?>(
                        value: _selectedMonth,
                        hint: const Text('  Tháng'),
                        isExpanded: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() => _selectedMonth = value);
                          _loadTransactions();
                        },
                        items: [
                          const DropdownMenuItem(value: null, child: Text('  Tất cả')),
                          ...List.generate(12, (i) => DropdownMenuItem(
                            value: '${DateTime.now().year}-${(i + 1).toString().padLeft(2, '0')}',
                            child: Text('  Tháng ${i + 1}'),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)],
                      ),
                      child: DropdownButton<String?>(
                        value: _selectedType,
                        hint: const Text('  Loại'),
                        isExpanded: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() => _selectedType = value);
                          _loadTransactions();
                        },
                        items: const [
                          DropdownMenuItem(value: null, child: Text('  Tất cả')),
                          DropdownMenuItem(value: 'INCOME', child: Text('  Thu nhập')),
                          DropdownMenuItem(value: 'EXPENSE', child: Text('  Chi tiêu')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// LIST
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _transactions.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_rounded, size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text('Không có giao dịch', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  final isIncome = tx.type == "INCOME";

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => _showEditDialog(tx),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.white, isIncome ? Colors.green.shade50 : Colors.red.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: isIncome ? Colors.green.shade200 : Colors.red.shade200,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isIncome ? Colors.green.shade100 : Colors.red.shade100,
                                ),
                                child: Icon(
                                  isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                                  color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx.categoryName,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    if (tx.note != null)
                                      Text(
                                        tx.note!,
                                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${tx.txnDate.day}/${tx.txnDate.month}/${tx.txnDate.year}',
                                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${isIncome ? "+" : "-"}${tx.amount.toStringAsFixed(0)}đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(null),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(Transaction? transaction) {
    final noteCtrl = TextEditingController(text: transaction?.note ?? '');
    final amountCtrl = TextEditingController(text: transaction?.amount.toString() ?? '');

    int? selectedCategoryId = transaction != null ? transaction.categoryId : null;
    String selectedType = transaction?.type ?? 'EXPENSE';
    String selectedPaymentMethod = transaction?.paymentMethod ?? 'CASH';
    DateTime selectedDateTime = transaction?.txnDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                transaction == null ? 'Thêm giao dịch' : 'Sửa giao dịch',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int?>(
                      value: selectedCategoryId,
                      hint: const Text('Chọn danh mục'),
                      isExpanded: true,
                      underline: Container(height: 2, color: Colors.blue.shade200),
                      onChanged: (value) => setStateDialog(() => selectedCategoryId = value),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('-- Vui lòng chọn --')),
                        ..._categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text(cat.name))).toList(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountCtrl,
                      decoration: InputDecoration(
                        labelText: 'Số tiền',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedType,
                      isExpanded: true,
                      underline: Container(height: 2, color: Colors.blue.shade200),
                      onChanged: (value) => setStateDialog(() => selectedType = value ?? 'EXPENSE'),
                      items: const [
                        DropdownMenuItem(value: 'INCOME', child: Text('Thu nhập')),
                        DropdownMenuItem(value: 'EXPENSE', child: Text('Chi tiêu')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Text('Ngày: ${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}')),
                        IconButton(icon: const Icon(Icons.calendar_today), onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDateTime,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setStateDialog(() {
                              selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, selectedDateTime.hour, selectedDateTime.minute);
                            });
                          }
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Giờ: ${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}')),
                        IconButton(icon: const Icon(Icons.access_time), onPressed: () async {
                          final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: selectedDateTime.hour, minute: selectedDateTime.minute));
                          if (pickedTime != null) {
                            setStateDialog(() {
                              selectedDateTime = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day, pickedTime.hour, pickedTime.minute);
                            });
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedPaymentMethod,
                      isExpanded: true,
                      underline: Container(height: 2, color: Colors.blue.shade200),
                      onChanged: (value) => setStateDialog(() => selectedPaymentMethod = value ?? 'CASH'),
                      items: const [
                        DropdownMenuItem(value: 'CASH', child: Text('Tiền mặt')),
                        DropdownMenuItem(value: 'BANK', child: Text('Ngân hàng')),
                        DropdownMenuItem(value: 'EWALLET', child: Text('Ví điện tử')),
                        DropdownMenuItem(value: 'OTHER', child: Text('Khác')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noteCtrl,
                      decoration: InputDecoration(
                        labelText: 'Ghi chú',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
                if (transaction != null)
                  TextButton(
                    onPressed: () async {
                      try {
                        if (transaction.id != null) await _service.deleteTransaction(transaction.id!);
                        if (mounted) Navigator.pop(context);
                        _loadTransactions();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi xóa: $e')));
                      }
                    },
                    child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (selectedCategoryId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn danh mục')));
                        return;
                      }
                      final newTx = Transaction(
                        id: transaction?.id,
                        categoryId: selectedCategoryId!,
                        categoryName: _categories.firstWhere((c) => c.id == selectedCategoryId, orElse: () => Category(id: 0, name: '', type: '')).name ?? '',
                        amount: double.parse(amountCtrl.text),
                        type: selectedType,
                        txnDate: selectedDateTime,
                        note: noteCtrl.text.isEmpty ? null : noteCtrl.text,
                        paymentMethod: selectedPaymentMethod,
                      );
                      if (transaction == null) {
                        await _service.createTransaction(newTx);
                      } else {
                        await _service.updateTransaction(newTx);
                      }
                      if (mounted) Navigator.pop(context);
                      _loadTransactions();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi lưu: $e')));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Lưu', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

