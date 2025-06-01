part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBooksEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final String title;
  final List<String> authors;
  final String coverImage;
  const AddBookEvent({
    required this.title,
    required this.authors,
    required this.coverImage,
  });

  @override
  List<Object> get props => [title, authors, coverImage];
}

class EditBookEvent extends BookEvent {
  final String id;
  final String title;
  final List<String> authors;
  final String coverImage;

  const EditBookEvent({
    required this.id,
    required this.title,
    required this.authors,
    required this.coverImage,
  });

  @override
  List<Object> get props => [id, title, authors, coverImage];
}

class DeleteBookEvent extends BookEvent {
  final String id;

  const DeleteBookEvent(this.id);

  @override
  List<Object> get props => [id];
}
