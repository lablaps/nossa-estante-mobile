import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';
import 'my_shelf_repository.dart';

/// Evento de navegação emitido pelo controller
class NavigationEvent {
  final String route;
  final Object? arguments;

  NavigationEvent(this.route, {this.arguments});
}

/// Enum para filtros da estante
enum ShelfFilter {
  all,
  available,
  inExchange,
  pending,
}

/// Extensão para ShelfFilter
extension ShelfFilterExtension on ShelfFilter {
  String get label {
    switch (this) {
      case ShelfFilter.all:
        return 'All Books';
      case ShelfFilter.available:
        return 'Available';
      case ShelfFilter.inExchange:
        return 'In Exchange';
      case ShelfFilter.pending:
        return 'Pending';
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

/// Controller para gerenciar o estado da página My Shelf
///
/// Ponto único de acesso aos dados do usuário.
/// Expõe entidades de domínio e handlers para a UI.
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

  /// Lista de filtros disponíveis
  final List<ShelfFilter> filters = ShelfFilter.values;

  /// Carrega dados iniciais
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

  /// Limpa navegação pendente (chamado após navegação ser executada)
  void clearNavigation() {
    _pendingNavigation = null;
  }

  /// Handler: Quando usuário toca em um livro
  void onBookTap(Book book) {
    _pendingNavigation = NavigationEvent('/book-details', arguments: book);
    notifyListeners();
  }

  /// Handler: Quando usuário seleciona um filtro
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

  /// Handler: Quando usuário toca no botão adicionar livro
  void onAddBookTap() {
    _pendingNavigation = NavigationEvent('/add-book');
    notifyListeners();
  }

  /// Recarrega os dados
  Future<void> refresh() async {
    await _loadData();
  }
}
