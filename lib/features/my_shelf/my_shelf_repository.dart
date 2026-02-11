import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository que fornece dados para a página My Shelf
///
/// Retorna livros do usuário atual usando mocks.
/// Futuramente será substituído por chamadas HTTP reais.
class MyShelfRepository {
  /// Busca todos os livros do usuário atual
  Future<List<Book>> fetchMyBooks(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBooks.findByOwner(userId);
  }

  /// Busca livros do usuário filtrados por status
  Future<List<Book>> fetchBooksByStatus(String userId, BookStatus? status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final myBooks = MockBooks.findByOwner(userId);
    
    if (status == null) {
      return myBooks;
    }
    
    return myBooks.where((book) => book.status == status).toList();
  }
}
