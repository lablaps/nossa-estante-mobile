import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository que fornece dados para a página Explorar
///
/// Retorna dados de domínio usando mocks.
/// Futuramente será substituído por chamadas HTTP reais.
class ExploreRepository {
  /// Busca livros em destaque
  Future<List<Book>> fetchFeaturedBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBooks.available.take(6).toList();
  }

  /// Busca novidades do catálogo
  Future<List<Book>> fetchNewArrivals() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBooks.available.skip(6).take(5).toList();
  }

  /// Busca livros filtrados por gênero
  Future<List<Book>> fetchBooksByGenre(String genre) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (genre == 'Todos') {
      return MockBooks.available;
    }

    return MockBooks.findByGenre(genre);
  }

  /// Busca todos os livros disponíveis
  Future<List<Book>> fetchAllBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBooks.available;
  }
}
