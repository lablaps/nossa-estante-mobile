import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';
import 'home_repository.dart';

/// Evento de navegação emitido pelo controller
class NavigationEvent {
  final String route;
  final Object? arguments;

  NavigationEvent(this.route, {this.arguments});
}

/// Controller para gerenciar o estado da Home
///
/// Ponto único de acesso aos dados.
/// Expõe entidades de domínio e handlers para a UI.
class HomeController extends ChangeNotifier {
  final HomeRepository _repository;

  HomeController({required HomeRepository repository})
    : _repository = repository {
    _loadData();
  }

  String _selectedFilter = 'Perto de mim';
  List<Book> _nearbyBooks = [];
  List<Exchange> _communityActivities = [];
  bool _isLoading = true;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  String get selectedFilter => _selectedFilter;
  List<Book> get nearbyBooks => _nearbyBooks;
  List<Exchange> get communityActivities => _communityActivities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;
  User get currentUser => MockUsers.currentUser;

  /// Conta livros dentro de um raio de 5km da localização atual do usuário
  int get totalBooksInRadius {
    // TODO: Usar localização real do usuário
    return _nearbyBooks.length;
  }

  /// Lista de filtros disponíveis
  final List<String> filters = [
    'Perto de mim',
    'Ficção',
    'Biografias',
    'Sci-Fi',
  ];

  /// Carrega dados iniciais
  Future<void> _loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final books = await _repository.fetchNearbyBooks();
      final activities = await _repository.fetchCommunityActivities();

      _nearbyBooks = books;
      _communityActivities = activities;
    } catch (e) {
      _errorMessage = 'Erro ao carregar dados: $e';
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

  /// Handler: Quando usuário toca em "Ver todos"
  void onViewAllNearby() {
    _pendingNavigation = NavigationEvent('/nearby-books');
    notifyListeners();
  }

  /// Handler: Quando usuário toca em uma atividade
  void onActivityTap(Exchange exchange) {
    _pendingNavigation = NavigationEvent('/book-details', arguments: exchange);
    notifyListeners();
  }

  /// Handler: Quando usuário toca no botão de notificações
  void onNotificationTap() {
    _pendingNavigation = NavigationEvent('/notifications');
    notifyListeners();
  }

  /// Handler: Quando usuário toca no mapa
  void onMapTap() {
    _pendingNavigation = NavigationEvent('/nearby-books');
    notifyListeners();
  }

  /// Altera o filtro selecionado
  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  /// Recarrega os dados
  Future<void> refresh() async {
    await _loadData();
  }
}
