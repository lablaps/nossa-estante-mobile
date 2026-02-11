import 'book.dart';
import 'user.dart';

/// Entidade de domínio: Avaliação de livro
class Review {
  final String id;
  final Book book;
  final User reviewer;
  final double rating; // De 0 a 5
  final String? comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.book,
    required this.reviewer,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Review copyWith({
    String? id,
    Book? book,
    User? reviewer,
    double? rating,
    String? comment,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      book: book ?? this.book,
      reviewer: reviewer ?? this.reviewer,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
