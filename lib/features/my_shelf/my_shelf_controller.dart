import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/domain/navigation_event.dart';
import '../../core/mocks/mocks.dart';
import 'my_shelf_repository.dart';

enum ShelfFilter { all, available, inExchange, pending }

extension ShelfFilterExtension on ShelfFilter {
  String get label {
    switch (this) {
      case ShelfFilter.all:
        return 'Todos os Livros';
      case ShelfFilter.available:
        return 'Disponível';
      case ShelfFilter.inExchange:
        return 'Em Troca';
      case ShelfFilter.pending:
        return 'Pendente';
    }
  }

  BookStatus? get bookStatus {
    switch (this) {
      case ShelfFilter.all:
        return null;
      case ShelfFilter.available:
        return BookStatus.available;
      case ShelfFilter.inExchange:
        return BookStatus.inExchange;
      case ShelfFilter.pending:
        return BookStatus.unavailable;
    }
  }
}

/// Controller da estante do usuário
///
/// Gerencia livros pessoais e filtragem por status
class MyShelfController extends ChangeNotifier {
  final MyShelfRepository _repository;

  MyShelfController({required MyShelfRepository repository})
    : _repository = repository {
    _loadData();
  }

  ShelfFilter _selectedFilter = ShelfFilter.all;
  List<Book> _myBooks = [];
  bool _isLoading = true;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  ShelfFilter get selectedFilter => _selectedFilter;
  List<Book> get myBooks => _myBooks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;
  User get currentUser => MockUsers.currentUser;
  bool get isEmpty => !_isLoading && _myBooks.isEmpty;

  final List<ShelfFilter> filters = ShelfFilter.values;

  Future<void> _loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final books = await _repository.fetchMyBooks(currentUser.id);
      _myBooks = books;
    } catch (e) {
      _errorMessage = 'Erro ao carregar seus livros: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearNavigation() {
    _pendingNavigation = null;
  }

  void onBookTap(Book book) {
    _pendingNavigation = NavigationEvent('/book-details', arguments: book);
    notifyListeners();
  }

  Future<void> onFilterSelected(ShelfFilter filter) async {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();

      try {
        final books = await _repository.fetchBooksByStatus(
          currentUser.id,
          filter.bookStatus,
        );
        _myBooks = books;
        notifyListeners();
      } catch (e) {
        _errorMessage = 'Erro ao filtrar livros: $e';
        notifyListeners();
      }
    }
  }

  void onAddBookTap() {
    _pendingNavigation = NavigationEvent('/add-book');
    notifyListeners();
  }

  Future<void> refresh() async {
    await _loadData();
  }
}
