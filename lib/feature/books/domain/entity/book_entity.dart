import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String title;
  final List<String> authors;
  final String coverImage;

  const BookEntity({
    required this.id,
    required this.title,
    required this.authors,
    required this.coverImage,
  });

  @override
  List<Object?> get props => [title, authors, coverImage];
}
