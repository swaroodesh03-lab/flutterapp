import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3001/api/v1', // catalog-service
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<Book>> getBooks() async {
    try {
      final response = await _dio.get('/books');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Book> getBookBySlug(String slug) async {
    try {
      final response = await _dio.get('/books/$slug');
      if (response.statusCode == 200) {
        return Book.fromJson(response.data);
      } else {
        throw Exception('Book not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final apiServiceProvider = Provider((ref) => ApiService());
