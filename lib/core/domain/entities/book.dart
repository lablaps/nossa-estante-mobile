import 'user.dart';

/// Entidade de domínio: Livro
class Book {
  final String id;
  final String title;
  final String author;
  final String? isbn;
  final String? coverUrl;
  final String? description;
  final List<String> genres;
  final User owner;
  final BookStatus status;
  final int creditsRequired;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.isbn,
    this.coverUrl,
    this.description,
    this.genres = const [],
    required this.owner,
    this.status = BookStatus.available,
    required this.creditsRequired,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? isbn,
    String? coverUrl,
    String? description,
    List<String>? genres,
    User? owner,
    BookStatus? status,
    int? creditsRequired,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      isbn: isbn ?? this.isbn,
      coverUrl: coverUrl ?? this.coverUrl,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      owner: owner ?? this.owner,
      status: status ?? this.status,
      creditsRequired: creditsRequired ?? this.creditsRequired,
    );
  }
}

/// Status de disponibilidade do livro
enum BookStatus {
  available, // Disponível para troca
  inExchange, // Em processo de troca
  unavailable, // Indisponível temporariamente
}
