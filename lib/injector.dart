import 'package:get_it/get_it.dart';
import 'package:mybooks/feature/books/data/datasourses/book_datasoruces.dart';
import 'package:mybooks/feature/books/data/repository/book_repository_impl.dart';
import 'package:mybooks/feature/books/domain/repository/book_repository.dart';
import 'package:mybooks/feature/books/domain/usecase/addbook_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/delete_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/edit_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/getbook_usecase.dart';
import 'package:mybooks/feature/books/presentation/bloc/bloc/book_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  //data Sources
  sl.registerLazySingleton<BookDatasoruces>(() => BookDatasorucesImpl());

  //repository from data layer

  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(bookDatasoruces: sl<BookDatasoruces>()),
  );

  //Usecases

  sl.registerLazySingleton(
    () => GetbookUsecase(bookRepository: sl<BookRepository>()),
  );

  sl.registerLazySingleton(
    () => AddbookUsecase(bookRepository: sl<BookRepository>()),
  );

  sl.registerLazySingleton(
    () => EditUsecase(bookRepository: sl<BookRepository>()),
  );

  sl.registerLazySingleton(
    () => DeletebookUsecase(bookRepository: sl<BookRepository>()),
  );

  //bloc

  sl.registerLazySingleton(
    () => BookBloc(
      getbookUsecase: sl<GetbookUsecase>(),
      addbookUsecase: sl<AddbookUsecase>(),
      editUsecase: sl<EditUsecase>(),
      deletebookUsecase: sl<DeletebookUsecase>(),
    ),
  );
}
