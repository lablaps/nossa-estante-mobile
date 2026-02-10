import 'package:flutter/material.dart';
import 'home_repository.dart';

/// Controller para gerenciar o estado da Home
class HomeController extends ChangeNotifier {
  final HomeRepository _repository;

  HomeController({required HomeRepository repository})
    : _repository = repository {
    _loadData();
  }

  String _selectedFilter = 'Perto de mim';
  List<Map<String, dynamic>> _nearbyBooks = [];
  List<Map<String, dynamic>> _communityActivities = [];
  bool _isLoading = true;

  String get selectedFilter => _selectedFilter;
  List<Map<String, dynamic>> get nearbyBooks => _nearbyBooks;
  List<Map<String, dynamic>> get communityActivities => _communityActivities;
  bool get isLoading => _isLoading;

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
    notifyListeners();

    try {
      final books = await _repository.fetchNearbyBooks();
      final activities = await _repository.fetchCommunityActivities();

      _nearbyBooks = books.map((book) => book.toMap()).toList();
      _communityActivities = activities
          .map((activity) => activity.toMap())
          .toList();
    } catch (e) {
      // Por enquanto, falhas silenciosas
      // Futuramente: tratamento de erro apropriado
      debugPrint('Erro ao carregar dados: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
