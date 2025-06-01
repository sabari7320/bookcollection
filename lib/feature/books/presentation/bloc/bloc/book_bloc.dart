// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mybooks/feature/books/domain/entity/book_entity.dart';
import 'package:mybooks/feature/books/domain/usecase/addbook_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/delete_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/edit_usecase.dart';
import 'package:mybooks/feature/books/domain/usecase/getbook_usecase.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetbookUsecase getbookUsecase;
  final AddbookUsecase addbookUsecase;
  final EditUsecase editUsecase;
  final DeletebookUsecase deletebookUsecase;
  BookBloc({
    required this.getbookUsecase,
    required this.addbookUsecase,
    required this.editUsecase,
    required this.deletebookUsecase,
  }) : super(BookInitial()) {
    on<GetBooksEvent>(_onGetbooks);
    on<AddBookEvent>(_onAddBook);
    on<EditBookEvent>(_onEditBook);
    on<DeleteBookEvent>(_onDeleteBook);
  }

  Future<void> _onGetbooks(GetBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await getbookUsecase.call();

    result.fold(
      (failure) {
        print("❌ Failed to fetch books: $failure");
        emit(BookError(message: failure.message));
      },
      (booklist) {
        print("✅ booklist fetched successfully: ${booklist.length} items");
        emit(BookLoaded(booklist: booklist));
      },
    );
  }

  Future<void> _onAddBook(AddBookEvent event, Emitter<BookState> emit) async {
    print("📚 AddBookEvent received: ${event.title}, ${event.authors}");
    emit(BookLoading());

    final result = await addbookUsecase.call(
      AddBookParams(
        title: event.title,
        author: event.authors,
        coverImage: event.coverImage,
      ),
    );

    result.fold(
      (failure) => emit(BookError(message: failure.message)),
      (_) => add(GetBooksEvent()), // refresh after success
    );
  }

  Future<void> _onEditBook(EditBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());

    final result = await editUsecase.call(
      EditBookParams(
        id: event.id,
        title: event.title,
        author: event.authors,
        coverImage: event.coverImage,
      ),
    );

    result.fold(
      (failure) => emit(BookError(message: failure.message)),
      (_) => add(GetBooksEvent()), // refresh
    );
  }

  Future<void> _onDeleteBook(
    DeleteBookEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());

    final result = await deletebookUsecase.call(DeletebookParams(id: event.id));

    result.fold(
      (failure) => emit(BookError(message: failure.message)),
      (_) => add(GetBooksEvent()), // refresh
    );
  }
}
