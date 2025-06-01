import 'package:dio/dio.dart';
import 'package:mybooks/core/api/api_constants.dart';
import 'package:mybooks/core/error/serverexception.dart';
import 'package:mybooks/feature/books/data/model/bookdata_model.dart';

abstract class BookDatasoruces {
  Future<List<BookModel>> getAllBooks();

  Future<void> addBook({
    required String title,
    required List<String> author,
    required String coverImage,
  });

  Future<void> updateBook({
    required String id,
    required String title,
    required List<String> author,
    required String coverImage,
  });

  Future<void> deleteBook({required String id});
}

class BookDatasorucesImpl extends BookDatasoruces {
  final Dio dio = Dio();

  @override
  Future<List<BookModel>> getAllBooks() async {
    try {
      final response = await dio.get(ApiConstants.bookurl);
      print("getAllBooks ${response.statusCode}");
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => BookModel.fromJson(e)).toList();
      } else {
        throw ServerException('Failed to fetch books');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? e.toString());
    }
  }

  @override
  Future<void> addBook({
    required String title,
    required List<String> author,
    required String coverImage,
  }) async {
    try {
      final bookData = {
        "title": title,
        "authors": author,
        "coverImage": coverImage,
      };
      final response = await dio.post(ApiConstants.bookurl, data: bookData);
      print("adding books1 ${response.statusCode}");
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException("Failed to add book");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? e.toString());
    }
  }

  @override
  Future<void> updateBook({
    required String id,
    required String title,
    required List<String> author,
    required String coverImage,
  }) async {
    try {
      final bookData = {
        "title": title,
        "authors": author,
        "coverImage": coverImage,
      };
      final response = await dio.put(
        '${ApiConstants.bookurl}/$id',
        data: bookData,
      );
      print("updateBook ${response.statusCode}");
      if (response.statusCode != 200) {
        throw ServerException("Failed to update book");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? e.toString());
    }
  }

  @override
  Future<void> deleteBook({required String id}) async {
    try {
      final response = await dio.delete('${ApiConstants.bookurl}/$id');
      print("deleteBook ${response.statusCode}");
      if (response.statusCode != 200) {
        throw ServerException("Failed to delete book");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? e.toString());
    }
  }
}
