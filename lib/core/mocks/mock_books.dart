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
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81pQPZAFWbL.jpg',
      description:
          'A história de Santiago, um jovem pastor andaluz que sonha encontrar um tesouro.',
      genres: ['Ficção', 'Filosofia'],
      owner: MockUsers.users[0], // Ana Silva
      status: BookStatus.available,
      condition: BookCondition.likeNew,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-002',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      isbn: '9788525432629',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/713jIoMO3UL.jpg',
      description:
          'Uma breve história da humanidade desde a Idade da Pedra até a era da tecnologia.',
      genres: ['História', 'Ciência'],
      owner: MockUsers.users[1], // Miguel Santos
      status: BookStatus.inExchange,
      condition: BookCondition.good,
      creditsRequired: 3,
    ),
    Book(
      id: 'book-003',
      title: 'Duna',
      author: 'Frank Herbert',
      isbn: '9788576573146',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81ym2eCIRyL.jpg',
      description: 'Uma das maiores obras de ficção científica já escritas.',
      genres: ['Ficção Científica', 'Aventura'],
      owner: MockUsers.users[2], // Lucas Oliveira
      status: BookStatus.available,
      condition: BookCondition.new_,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-004',
      title: '1984',
      author: 'George Orwell',
      isbn: '9788535914849',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71kxa1-0mfL.jpg',
      description: 'Uma distopia sobre vigilância, controle e manipulação.',
      genres: ['Ficção', 'Distopia'],
      owner: MockUsers.users[3], // Julia Costa
      status: BookStatus.unavailable,
      condition: BookCondition.fair,
      creditsRequired: 1,
    ),
    Book(
      id: 'book-005',
      title: 'O Senhor dos Anéis',
      author: 'J.R.R. Tolkien',
      isbn: '9788595084742',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/91dSMhdIzTL.jpg',
      description: 'A épica jornada de Frodo para destruir o Um Anel.',
      genres: ['Fantasia', 'Aventura'],
      owner: MockUsers.users[4], // Pedro Almeida
      status: BookStatus.available,
      condition: BookCondition.good,
      creditsRequired: 3,
    ),
    Book(
      id: 'book-006',
      title: 'A Culpa é das Estrelas',
      author: 'John Green',
      isbn: '9788580573466',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81a4kCNuH+L.jpg',
      description: 'A história de amor entre Hazel e Augustus.',
      genres: ['Romance', 'Drama'],
      owner: MockUsers.users[0], // Ana Silva
      status: BookStatus.available,
      condition: BookCondition.new_,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-007',
      title: 'Harry Potter e a Pedra Filosofal',
      author: 'J.K. Rowling',
      isbn: '9788532530802',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81YOuOGFCJL.jpg',
      description: 'O início da jornada mágica de Harry Potter.',
      genres: ['Fantasia', 'Aventura'],
      owner: MockUsers.users[1], // Miguel Santos
      status: BookStatus.available,
      condition: BookCondition.good,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-008',
      title: 'O Código Da Vinci',
      author: 'Dan Brown',
      isbn: '9788580411966',
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/91Q5dCjc2KL.jpg',
      description: 'Mistério e suspense envolvendo simbologias religiosas.',
      genres: ['Suspense', 'Mistério'],
      owner: MockUsers.users[2], // Lucas Oliveira
      status: BookStatus.available,
      condition: BookCondition.likeNew,
      creditsRequired: 2,
    ),
    // Livros do usuário atual
    Book(
      id: 'book-009',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      isbn: '9780062315007',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBszs3h4WDG0I5WxPqYF1tF7Dpom_SEE38vkBg2JIUUKpudksS9FnzHu2LkE71xjrV9wNMoqEsn83XapL5Y00UH-fGHeCB9qFvyyNgRc4pLHbUn63z6SfnkhYUwyDNY1Gy-emGB4V5ZNQltLSaciec5soxbHK6sBRNmjtB-J071bQShUGK9fuo1dXuqXWWMGsh4xXLtt1hvLqNBR8rvI4Ipd9bSNAwMGITEgZeqOXQDi5pr81tBhzRYHo5oAmLykZPLiCP8dUDiZPdA',
      description: 'A magical fable about following your dreams.',
      genres: ['Ficção', 'Filosofia'],
      owner: MockUsers.currentUser,
      status: BookStatus.available,
      condition: BookCondition.likeNew,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-010',
      title: 'Sapiens: A Brief History of Humankind',
      author: 'Yuval Noah Harari',
      isbn: '9780062316110',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuC6zgJXBTYsxRunjHIYvRYmShnpqlHC-i3VMhYd1IkIgnHydA1QHhfKPCEOjbTdpRdEbKTbexf3gwLuTH7DFEevZEnYQEeVtxsevmRC4zTG8aMoetqrtJJPyLxy-ahz-TeWtAsEV3j6Z5-FbrtJppzK-h2_f_Id5i41GlJiLkSeMwqNBz9y7qvfSGnkSaYWv4gknF_9lAmOecmLPUC9AvziCVWQGDnxkVQif_Lzs7a8Pf-k6UXBCam30CBylkhDf3hUvjP-FXWqkj1y',
      description: 'From the Stone Age to the Silicon Age.',
      genres: ['História', 'Ciência'],
      owner: MockUsers.currentUser,
      status: BookStatus.inExchange,
      condition: BookCondition.good,
      creditsRequired: 3,
    ),
    Book(
      id: 'book-011',
      title: 'Atomic Habits',
      author: 'James Clear',
      isbn: '9780735211292',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCU6gvG9cvY32_7ltoRqlQPiRDuK2g1CteNqGoqg09ROMk1JeguOS_yrTrUvPEQUW3AHUd0oGgPLeGg7XKjk2dKVEZlZaR2vA3wDmh0BHkn8QHZJramuyGSVWCguehj3yB5SorV15R6PUc0Hx5nwDbBZAP3yxsCFo1GR-cT68E9k1xG8HnyfqLwK6X3od6g8H09qNcBfWzV9AZdi7orAZAjBuCm3SH9XdTJQSgL-yOIrb8BYMKH2qCqCydbzZPxdGuqt8967gDjQ-Wb',
      description: 'An Easy & Proven Way to Build Good Habits.',
      genres: ['Autoajuda', 'Produtividade'],
      owner: MockUsers.currentUser,
      status: BookStatus.available,
      condition: BookCondition.new_,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-012',
      title: '1984',
      author: 'George Orwell',
      isbn: '9780451524935',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDena87BbX6E74Bo8tgV2UTs6QJbVIl-Vv-k7CLmRc0d_itdrdjke5XVkmsaQ3-b3yBXsV5awmVt4nf_EFQUZ4marxbcRCC78QZipJE75mRbG0lYcHUXW_nL8yHP6NHYsMOPKm8IZrEpp2SQKvAMBlZOeH7XwjwreGowenJwEuji5fN1bPI6Ppeo0OsNX8GJBEcID6wFR56fIZdrhGDDT7FHXUIjv0CzDwLZ8OombCT-2BLJiHRJI3uYo2uWRLW4-Mm27BxGgQVkHfd',
      description: 'A dystopian social science fiction novel.',
      genres: ['Ficção', 'Distopia'],
      owner: MockUsers.currentUser,
      status: BookStatus.unavailable,
      condition: BookCondition.fair,
      creditsRequired: 1,
    ),
    Book(
      id: 'book-013',
      title: 'The Design of Everyday Things',
      author: 'Don Norman',
      isbn: '9780465050659',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBLWN1DqHtE8ItpULxxW8MPY3U67Hfqn9b54lnJeTZ9jzrdTiqZGNsbbZXqKHqxij81dBmtN8kNRGAP5CeMIdHK_DcgbXRrfhxxxOoSaIz21ErGHzooqW5KEGWAXlTAV3YBDungXB2ZEp8xSsWOYe4lVzkJncRdT7by5fTTcefxoZwKj81w1cQy0LXrHvJsbSgN_tvLqXGn5yixUpsNTx0888bFFq0cesP0x7mavto2kH-h1_JalmAaV3rttsk3VFSBXwpJLasmLPf9',
      description: 'Revised and expanded edition.',
      genres: ['Design', 'Tecnologia'],
      owner: MockUsers.currentUser,
      status: BookStatus.available,
      condition: BookCondition.good,
      creditsRequired: 2,
    ),
    Book(
      id: 'book-014',
      title: 'Dune',
      author: 'Frank Herbert',
      isbn: '9780441172719',
      coverUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCfVr3xDLPg5J0XyW6S5RVvJI4LEcYSsSIXNCQIFMH_McB6PNy21gvrSgLJTL8j3oiumTNsvxCFwXYO09J0HcFA-a3-s3y_ePxtZVWy3dR-t703URjFe6r_okFpY_9lShsu6dpz4CjNrXYBS49-FSG3cmZ3NT0NJg5L6H068HT_Rmip8SrVK0KT5z9ItJeqMdzRGrfLwkPdmHTs-8eV0bgbw47JDc48r1o3mkfaXjX8qWe-IkXAx5JqVWKNjqUsMwZ6p8VLNfBF4aqT',
      description: 'The greatest science fiction novel ever written.',
      genres: ['Ficção Científica', 'Fantasia'],
      owner: MockUsers.currentUser,
      status: BookStatus.available,
      condition: BookCondition.new_,
      creditsRequired: 3,
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
