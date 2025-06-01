import 'package:fpdart/fpdart.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/core/usecase/usecase.dart';
import 'package:mybooks/feature/books/domain/repository/book_repository.dart';

class DeletebookUsecase extends UsecaseWithParams<void, DeletebookParams> {
  final BookRepository bookRepository;
  DeletebookUsecase({required this.bookRepository});
  @override
  Future<Either<Failure, void>> call(DeletebookParams Params) async {
    return await bookRepository.deletebooks(id: Params.id);
  }
}

class DeletebookParams {
  final String id;
  DeletebookParams({required this.id});
}
