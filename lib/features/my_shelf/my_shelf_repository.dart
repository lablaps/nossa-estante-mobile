import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository da estante do usuário
class MyShelfRepository {
  Future<List<Book>> fetchMyBooks(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBooks.findByOwner(userId);
  }

  Future<List<Book>> fetchBooksByStatus(
    String userId,
    BookStatus? status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final myBooks = MockBooks.findByOwner(userId);

    if (status == null) {
      return myBooks;
    }

    return myBooks.where((book) => book.status == status).toList();
  }
}
