import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

class AddBookRepository {
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
