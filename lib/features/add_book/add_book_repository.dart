import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository para adicionar livros à estante do usuário
///
/// Gerencia a adição de novos livros à lista mockada.
/// Futuramente será substituído por chamadas à API.
class AddBookRepository {
  /// Adiciona um novo livro à lista global de livros
  Future<void> addBook(Book book) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));

    // Adiciona o livro à lista mockada
    MockBooks.books.add(book);
  }

  /// Valida se um ISBN já existe
  Future<bool> isbnExists(String isbn) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return MockBooks.books.any((book) => book.isbn == isbn);
  }
}
