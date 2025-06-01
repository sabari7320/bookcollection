import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/core/usecase/usecase.dart';
import 'package:mybooks/feature/books/domain/entity/book_entity.dart';
import 'package:mybooks/feature/books/domain/repository/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetbookUsecase extends NoParams {
  final BookRepository bookRepository;
  GetbookUsecase({required this.bookRepository});

  Future<Either<Failure, List<BookEntity>>> call() async {
    return await bookRepository.getallbooks();
  }
}
