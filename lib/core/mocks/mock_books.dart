import '../domain/entities/entities.dart';
import 'mock_users.dart';

/// Mocks de livros para desenvolvimento e testes
class MockBooks {
  /// Lista de livros mockados
  static final List<Book> books = [
    Book(
      id: 'book-001',
      title: 'O Alquimista',
      author: 'Paulo Coelho',
      isbn: '9788576651239',
      description:
          'A história de Santiago, um jovem pastor andaluz que sonha encontrar um tesouro.',
      genres: ['Ficção', 'Filosofia'],
      owner: MockUsers.users[0], // Ana Silva
      status: BookStatus.available,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-002',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      isbn: '9788525432629',
      description:
          'Uma breve história da humanidade desde a Idade da Pedra até a era da tecnologia.',
      genres: ['História', 'Ciência'],
      owner: MockUsers.users[1], // Miguel Santos
      status: BookStatus.available,
      creditsRequired: 3,
    ),
    Book(
      id: 'book-003',
      title: 'Duna',
      author: 'Frank Herbert',
      isbn: '9788576573146',
      description: 'Uma das maiores obras de ficção científica já escritas.',
      genres: ['Ficção Científica', 'Aventura'],
      owner: MockUsers.users[2], // Lucas Oliveira
      status: BookStatus.available,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-004',
      title: '1984',
      author: 'George Orwell',
      isbn: '9788535914849',
      description: 'Uma distopia sobre vigilância, controle e manipulação.',
      genres: ['Ficção', 'Distopia'],
      owner: MockUsers.users[3], // Julia Costa
      status: BookStatus.available,
      creditsRequired: 1,
    ),
    Book(
      id: 'book-005',
      title: 'O Senhor dos Anéis',
      author: 'J.R.R. Tolkien',
      isbn: '9788595084742',
      description: 'A épica jornada de Frodo para destruir o Um Anel.',
      genres: ['Fantasia', 'Aventura'],
      owner: MockUsers.users[4], // Pedro Almeida
      status: BookStatus.available,
      creditsRequired: 3,
    ),
    Book(
      id: 'book-006',
      title: 'A Culpa é das Estrelas',
      author: 'John Green',
      isbn: '9788580573466',
      description: 'A história de amor entre Hazel e Augustus.',
      genres: ['Romance', 'Drama'],
      owner: MockUsers.users[0], // Ana Silva
      status: BookStatus.available,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-007',
      title: 'Harry Potter e a Pedra Filosofal',
      author: 'J.K. Rowling',
      isbn: '9788532530802',
      description: 'O início da jornada mágica de Harry Potter.',
      genres: ['Fantasia', 'Aventura'],
      owner: MockUsers.users[1], // Miguel Santos
      status: BookStatus.available,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-008',
      title: 'O Código Da Vinci',
      author: 'Dan Brown',
      isbn: '9788580411966',
      description: 'Mistério e suspense envolvendo simbologias religiosas.',
      genres: ['Suspense', 'Mistério'],
      owner: MockUsers.users[2], // Lucas Oliveira
      status: BookStatus.available,
      creditsRequired: 2,
    ),
  ];

  /// Busca livro por ID
  static Book? findById(String id) {
    try {
      return books.firstWhere((book) => book.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Busca livros por gênero
  static List<Book> findByGenre(String genre) {
    return books.where((book) => book.genres.contains(genre)).toList();
  }

  /// Busca livros disponíveis
  static List<Book> get available {
    return books.where((book) => book.status == BookStatus.available).toList();
  }

  /// Busca livros de um usuário específico
  static List<Book> findByOwner(String userId) {
    return books.where((book) => book.owner.id == userId).toList();
  }

  /// Retorna livros próximos de uma localização
  /// Ordenados por distância (mais próximo primeiro)
  static List<Book> findNearby(UserLocation location, {int limit = 10}) {
    final booksWithDistance = books
        .where(
          (book) =>
              book.status == BookStatus.available &&
              book.owner.location != null,
        )
        .map((book) {
          final distance = location.distanceTo(book.owner.location!);
          return {'book': book, 'distance': distance};
        })
        .toList();

    booksWithDistance.sort(
      (a, b) => (a['distance'] as double).compareTo(b['distance'] as double),
    );

    return booksWithDistance
        .take(limit)
        .map((item) => item['book'] as Book)
        .toList();
  }
}
