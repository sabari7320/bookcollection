import 'package:fpdart/fpdart.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/core/usecase/usecase.dart';

import 'package:mybooks/feature/books/domain/repository/book_repository.dart';

class EditUsecase extends UsecaseWithParams<void, EditBookParams> {
  final BookRepository bookRepository;

  EditUsecase({required this.bookRepository});

  @override
  Future<Either<Failure, void>> call(EditBookParams Params) async {
    return await bookRepository.editbooks(
      id: Params.id,
      title: Params.title,
      author: Params.author,
      coverImage: Params.coverImage,
    );
  }
}

class EditBookParams {
  final String id;
  final String title;
  final List<String> author;
  final String coverImage;

  EditBookParams({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImage,
  });
}
