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
  final BookCondition condition;
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
    this.condition = BookCondition.good,
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
    BookCondition? condition,
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
      condition: condition ?? this.condition,
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

/// Condição física do livro
enum BookCondition {
  new_, // Novo (sem uso)
  likeNew, // Como novo
  good, // Bom estado
  fair, // Estado aceitável
}

/// Extensão para BookCondition
extension BookConditionExtension on BookCondition {
  String get label {
    switch (this) {
      case BookCondition.new_:
        return 'New';
      case BookCondition.likeNew:
        return 'Like New';
      case BookCondition.good:
        return 'Good';
      case BookCondition.fair:
        return 'Fair';
    }
  }
}

/// Extensão para BookStatus
extension BookStatusExtension on BookStatus {
  String get label {
    switch (this) {
      case BookStatus.available:
        return 'Available';
      case BookStatus.inExchange:
        return 'In Exchange';
      case BookStatus.unavailable:
        return 'Pending';
    }
  }
}
