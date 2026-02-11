import '../domain/entities/entities.dart';
import 'mock_users.dart';
import 'mock_books.dart';

/// Mocks de avaliações para desenvolvimento e testes
class MockReviews {
  /// Lista de avaliações mockadas
  static final List<Review> reviews = [
    Review(
      id: 'review-001',
      book: MockBooks.books[0], // O Alquimista
      reviewer: MockUsers.users[1], // Miguel Santos
      rating: 4.5,
      comment:
          'Uma leitura inspiradora! Muito além de uma simples história de aventura.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Review(
      id: 'review-002',
      book: MockBooks.books[1], // Sapiens
      reviewer: MockUsers.users[0], // Ana Silva
      rating: 5.0,
      comment: 'Mudou completamente minha perspectiva sobre a humanidade.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Review(
      id: 'review-003',
      book: MockBooks.books[2], // Duna
      reviewer: MockUsers.users[3], // Julia Costa
      rating: 4.0,
      comment:
          'Clássico da ficção científica. Começa devagar mas vale muito a pena.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Review(
      id: 'review-004',
      book: MockBooks.books[3], // 1984
      reviewer: MockUsers.users[4], // Pedro Almeida
      rating: 5.0,
      comment: 'Assustadoramente relevante mesmo hoje. Leitura obrigatória.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Review(
      id: 'review-005',
      book: MockBooks.books[4], // O Senhor dos Anéis
      reviewer: MockUsers.users[2], // Lucas Oliveira
      rating: 4.8,
      comment: 'A obra-prima da fantasia. Worldbuilding incomparável.',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  /// Busca avaliação por ID
  static Review? findById(String id) {
    try {
      return reviews.firstWhere((review) => review.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Busca avaliações de um livro específico
  static List<Review> findByBook(String bookId) {
    return reviews.where((review) => review.book.id == bookId).toList();
  }

  /// Busca avaliações de um usuário específico
  static List<Review> findByReviewer(String userId) {
    return reviews.where((review) => review.reviewer.id == userId).toList();
  }

  /// Calcula média de avaliações de um livro
  static double getAverageRating(String bookId) {
    final bookReviews = findByBook(bookId);
    if (bookReviews.isEmpty) return 0.0;

    final sum = bookReviews.fold<double>(
      0.0,
      (sum, review) => sum + review.rating,
    );
    return sum / bookReviews.length;
  }

  /// Retorna avaliações recentes
  static List<Review> getRecent({int limit = 10}) {
    final recentReviews = List<Review>.from(reviews);
    recentReviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return recentReviews.take(limit).toList();
  }
}
