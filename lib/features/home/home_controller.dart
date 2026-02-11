import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import 'home_repository.dart';

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

  // Getters - Expõem dados de domínio
  String get selectedFilter => _selectedFilter;
  List<Book> get nearbyBooks => _nearbyBooks;
  List<Exchange> get communityActivities => _communityActivities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Handlers (ações da UI) ---

  /// Handler: Quando usuário toca em um livro
  void onBookTap(Book book) {
    debugPrint('Navegação: Detalhes do livro "${book.title}"');
    // TODO: Navegar para detalhes do livro
  }

  /// Handler: Quando usuário toca em "Ver todos"
  void onSeeAllBooks() {
    debugPrint('Navegação: Ver todos os livros');
    // TODO: Navegar para lista completa de livros filtrados
  }

  /// Handler: Quando usuário toca em uma atividade
  void onActivityTap(Exchange exchange) {
    debugPrint('Navegação: Detalhes da troca ${exchange.id}');
    // TODO: Navegar para detalhes da troca
  }

  /// Handler: Quando usuário toca no mapa
  void onMapTap() {
    debugPrint('Navegação: Visualização do mapa completo');
    // TODO: Navegar para mapa em tela cheia
  }

  /// Altera o filtro selecionado
  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
      // Futuramente: recarregar dados baseado no filtro
    }
  }

  /// Recarrega os dados
  Future<void> refresh() async {
    await _loadData();
  }
}
