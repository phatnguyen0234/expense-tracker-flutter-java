import 'package:dio/dio.dart';
import '../models/category.dart';

class CategoryService {
  final Dio _dio;

  CategoryService(this._dio);

  Future<List<Category>> getCategories({String? type}) async {
    try {
      final response = await _dio.get(
        '/categories',
        queryParameters: {
          if (type != null) 'type': type,
        },
      );
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> createCategory(Category category) async {
    try {
      final response = await _dio.post(
        '/categories',
        data: category.toJson(),
      );
      return Category.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> updateCategory(int id, Category category) async {
    try {
      final response = await _dio.put(
        '/categories/$id',
        data: category.toJson(),
      );
      return Category.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await _dio.delete('/categories/$id');
    } catch (e) {
      rethrow;
    }
  }
}

