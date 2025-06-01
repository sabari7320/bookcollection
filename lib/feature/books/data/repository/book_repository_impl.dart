import 'package:fpdart/fpdart.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/feature/books/data/datasourses/book_datasoruces.dart';
import 'package:mybooks/feature/books/domain/entity/book_entity.dart';
import 'package:mybooks/feature/books/domain/repository/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  final BookDatasoruces bookDatasoruces;

  BookRepositoryImpl({required this.bookDatasoruces});

  @override
  Future<Either<Failure, void>> addbooks({
    required String title,
    required List<String> author,
    required String coverImage,
  }) async {
    try {
      final book = await bookDatasoruces.addBook(
        title: title,
        author: author,
        coverImage: coverImage,
      );
      return Right(book);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletebooks({required String id}) async {
    try {
      await bookDatasoruces.deleteBook(id: id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editbooks({
    required String id,
    required String title,
    required author,
    required coverImage,
  }) async {
    try {
      final updatedBook = await bookDatasoruces.updateBook(
        id: id,
        title: title,
        author: author,
        coverImage: coverImage,
      );
      return Right(updatedBook);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getallbooks() async {
    try {
      final books = await bookDatasoruces.getAllBooks();
      return Right(books);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
