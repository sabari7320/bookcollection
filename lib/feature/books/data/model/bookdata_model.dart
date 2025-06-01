import 'package:mybooks/feature/books/domain/entity/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.id,
    required super.title,
    required super.authors,
    required super.coverImage,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"] ?? '',
      title: json["title"] ?? 'Unknown',
      authors: List<String>.from(json['authors'] ?? []),
      coverImage: json["coverImageUrl"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'authors': authors,
      'coverImage': coverImage,
    };
  }
}
