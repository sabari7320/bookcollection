import 'package:fpdart/fpdart.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/feature/books/domain/entity/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getallbooks();

  Future<Either<Failure, void>> addbooks({
    required String title,
    required List<String> author,
    required String coverImage,
  });

  Future<Either<Failure, void>> editbooks({
    required String id,
    required String title,
    required author,
    required coverImage,
  });

  Future<Either<Failure, void>> deletebooks({required String id});
}
