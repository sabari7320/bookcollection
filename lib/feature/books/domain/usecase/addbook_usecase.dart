import 'package:fpdart/fpdart.dart';
import 'package:mybooks/core/error/failure.dart';
import 'package:mybooks/core/usecase/usecase.dart';

import 'package:mybooks/feature/books/domain/repository/book_repository.dart';

class AddbookUsecase extends UsecaseWithParams<void, AddBookParams> {
  final BookRepository bookRepository;
  AddbookUsecase({required this.bookRepository});
  @override
  Future<Either<Failure, void>> call(AddBookParams params) async {
    return await bookRepository.addbooks(
      title: params.title,
      author: params.author,
      coverImage: params.coverImage,
    );
  }
}

class AddBookParams {
  final String title;
  final List<String> author;
  final String coverImage;

  AddBookParams({
    required this.title,
    required this.author,
    required this.coverImage,
  });
}
