import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/domain/navigation_event.dart';
import '../../core/mocks/mocks.dart';
import 'home_repository.dart';

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

  int get totalBooksInRadius {
    return _nearbyBooks.length;
  }

  final List<String> filters = [
    'Perto de mim',
    'Ficção',
    'Biografias',
    'Sci-Fi',
  ];

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

  void clearNavigation() {
    _pendingNavigation = null;
  }

  void onBookTap(Book book) {
    _pendingNavigation = NavigationEvent('/book-details', arguments: book);
    notifyListeners();
  }

  void onViewAllNearby() {
    _pendingNavigation = NavigationEvent('/nearby-books');
    notifyListeners();
  }

  void onActivityTap(Exchange exchange) {
    _pendingNavigation = NavigationEvent('/book-details', arguments: exchange);
    notifyListeners();
  }

  void onNotificationTap() {
    _pendingNavigation = NavigationEvent('/notifications');
    notifyListeners();
  }

  void onMapTap() {
    _pendingNavigation = NavigationEvent('/nearby-books');
    notifyListeners();
  }

  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await _loadData();
  }
}
