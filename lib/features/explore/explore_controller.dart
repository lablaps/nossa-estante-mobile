import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';
import 'explore_repository.dart';

/// Evento de navegação emitido pelo controller
class NavigationEvent {
  final String route;
  final Object? arguments;

  NavigationEvent(this.route, {this.arguments});
}

/// Modelo para coleção curada
class CuratedCollection {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String badgeText;
  final Color badgeColor;

  const CuratedCollection({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.badgeText,
    required this.badgeColor,
  });
}

/// Controller para gerenciar o estado da página Explorar
///
/// Ponto único de acesso aos dados.
/// Expõe entidades de domínio e handlers para a UI.
class ExploreController extends ChangeNotifier {
  final ExploreRepository _repository;

  ExploreController({required ExploreRepository repository})
    : _repository = repository {
    _loadData();
  }

  String _selectedGenre = 'Ficção';
  List<Book> _featuredBooks = [];
  List<Book> _newArrivals = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = true;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  String get selectedGenre => _selectedGenre;
  List<Book> get featuredBooks => _featuredBooks;
  List<Book> get newArrivals => _newArrivals;
  List<Book> get filteredBooks => _filteredBooks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;
  User get currentUser => MockUsers.currentUser;

  /// Lista de gêneros disponíveis para filtro
  final List<String> genres = [
    'Ficção',
    'Romance',
    'Biografia',
    'Fantasia',
    'Tecnologia',
    'História',
  ];

  /// Lista de coleções curadas
  final List<CuratedCollection> curatedCollections = const [
    CuratedCollection(
      id: 'classics',
      title: 'Clássicos Imperdíveis',
      description: 'Obras que marcaram gerações.',
      imageUrl:
          'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800&h=400&fit=crop',
      badgeText: 'EDITORIAL',
      badgeColor: Color(0xFF13EC5B),
    ),
    CuratedCollection(
      id: 'awards',
      title: 'Vencedores de Prêmios',
      description: 'Os melhores do ano.',
      imageUrl:
          'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800&h=400&fit=crop',
      badgeText: 'TRENDING',
      badgeColor: Color(0xFF9333EA),
    ),
  ];

  /// Carrega dados iniciais
  Future<void> _loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final featured = await _repository.fetchFeaturedBooks();
      final arrivals = await _repository.fetchNewArrivals();
      final filtered = await _repository.fetchBooksByGenre(_selectedGenre);

      _featuredBooks = featured;
      _newArrivals = arrivals;
      _filteredBooks = filtered;
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

  /// Handler: Quando usuário seleciona um filtro de gênero
  Future<void> onFilterSelected(String genre) async {
    if (_selectedGenre != genre) {
      _selectedGenre = genre;
      notifyListeners();

      try {
        final filtered = await _repository.fetchBooksByGenre(genre);
        _filteredBooks = filtered;
        notifyListeners();
      } catch (e) {
        _errorMessage = 'Erro ao filtrar livros: $e';
        notifyListeners();
      }
    }
  }

  /// Handler: Quando usuário toca em "Ver todos" da seção em destaque
  void onViewAllFeatured() {
    _pendingNavigation = NavigationEvent('/featured');
    notifyListeners();
  }

  /// Handler: Quando usuário toca em uma coleção curada
  void onCollectionTap(String collectionId) {
    _pendingNavigation = NavigationEvent(
      '/collection',
      arguments: collectionId,
    );
    notifyListeners();
  }

  /// Handler: Quando usuário toca no botão adicionar de um livro
  void onAddBookTap(Book book) {
    // TODO: Implementar lógica de adicionar livro à lista de desejos
    _pendingNavigation = NavigationEvent('/book-details', arguments: book);
    notifyListeners();
  }

  /// Recarrega os dados
  Future<void> refresh() async {
    await _loadData();
  }
}
