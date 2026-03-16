import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import '../../../core/api/dio_client.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  late CategoryService _categoryService;
  List<Category> _categories = [];
  String _selectedTypeFilter = 'EXPENSE';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService(DioClient.dio);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final categories =
          await _categoryService.getCategories(type: _selectedTypeFilter);
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lỗi tải danh mục: $e')));
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý danh mục', style: TextStyle(fontWeight: FontWeight.bold)),
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
            colors: [Colors.orange.shade50, Colors.amber.shade50],
          ),
        ),
        child: Column(
          children: [
            /// Filter by type
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 16), child: Text('Loại: ', style: TextStyle(fontWeight: FontWeight.w500))),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedTypeFilter,
                        isExpanded: true,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedTypeFilter = value);
                            _loadCategories();
                          }
                        },
                        items: const [
                          DropdownMenuItem(value: 'EXPENSE', child: Text('Chi tiêu')),
                          DropdownMenuItem(value: 'INCOME', child: Text('Thu nhập')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// List categories
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _categories.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category_rounded, size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text('Không có danh mục', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.orange.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: Colors.orange.shade200, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange.shade100,
                              ),
                              child: Icon(
                                Icons.label_rounded,
                                color: Colors.orange.shade700,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category.type == 'INCOME' ? 'Thu nhập' : 'Chi tiêu',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue.shade600),
                              onPressed: () => _showEditDialog(category),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _showDeleteDialog(category),
                            ),
                          ],
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
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(Category? category) {
    final nameCtrl =
        TextEditingController(text: category?.name ?? '');
    String selectedType = category?.type ?? _selectedTypeFilter;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                category == null ? 'Thêm danh mục' : 'Sửa danh mục',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Tên danh mục'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: selectedType,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() => selectedType = value);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                          value: 'EXPENSE', child: Text('Chi tiêu')),
                      DropdownMenuItem(
                          value: 'INCOME', child: Text('Thu nhập')),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () async {
                    if (nameCtrl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Vui lòng nhập tên danh mục')),
                      );
                      return;
                    }

                    try {
                      final newCategory = Category(
                        id: category?.id ?? 0,
                        name: nameCtrl.text,
                        type: selectedType,
                      );

                      if (category == null) {
                        await _categoryService.createCategory(newCategory);
                      } else {
                        await _categoryService.updateCategory(
                            category.id, newCategory);
                      }

                      if (mounted) Navigator.pop(context);
                      _loadCategories();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lỗi lưu: $e')),
                      );
                    }
                  },
                  child: const Text('Lưu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa danh mục'),
        content: Text('Bạn có chắc chắn muốn xóa "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _categoryService.deleteCategory(category.id);
                if (mounted) Navigator.pop(context);
                _loadCategories();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi xóa: $e')),
                );
              }
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

