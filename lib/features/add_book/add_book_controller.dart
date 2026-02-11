import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/routes/navigation_event.dart';
import '../../core/mocks/mock_users.dart';
import 'add_book_repository.dart';

/// Controller para gerenciar o estado da tela de adicionar livro
///
/// Responsabilidades:
/// - Gerenciar estado do formulário
/// - Validar dados de entrada
/// - Emitir eventos de navegação
/// - Coordenar com repository para persistir dados
class AddBookController extends ChangeNotifier {
  final AddBookRepository _repository;

  AddBookController({required AddBookRepository repository})
    : _repository = repository;

  // ========== ESTADO DO FORMULÁRIO ==========

  String _title = '';
  String _author = '';
  String _isbn = '';
  String _coverUrl = '';
  String _description = '';
  List<String> _selectedGenres = [];
  int _creditsRequired = 1;
  BookCondition _condition = BookCondition.good;
  String? _language;
  int? _pageCount;

  // ========== ESTADO DA UI ==========

  bool _isLoading = false;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  // ========== GETTERS ==========

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;
  User get currentUser => MockUsers.currentUser;

  String get title => _title;
  String get author => _author;
  String get isbn => _isbn;
  String get coverUrl => _coverUrl;
  String get description => _description;
  List<String> get selectedGenres => _selectedGenres;
  int get creditsRequired => _creditsRequired;
  BookCondition get condition => _condition;
  String? get language => _language;
  int? get pageCount => _pageCount;

  // ========== SETTERS DE FORMULÁRIO ==========

  void setTitle(String value) {
    _title = value;
    _clearError();
  }

  void setAuthor(String value) {
    _author = value;
    _clearError();
  }

  void setIsbn(String value) {
    _isbn = value;
    _clearError();
  }

  void setCoverUrl(String value) {
    _coverUrl = value;
    _clearError();
  }

  void setDescription(String value) {
    _description = value;
    _clearError();
  }

  void setGenres(List<String> genres) {
    _selectedGenres = genres;
    _clearError();
    notifyListeners();
  }

  void setCreditsRequired(int value) {
    if (value >= 1 && value <= 10) {
      _creditsRequired = value;
      _clearError();
      notifyListeners();
    }
  }

  void setCondition(BookCondition value) {
    _condition = value;
    _clearError();
    notifyListeners();
  }

  void setLanguage(String? value) {
    _language = value;
    _clearError();
    notifyListeners();
  }

  void setPageCount(int? value) {
    _pageCount = value;
    _clearError();
    notifyListeners();
  }

  // ========== VALIDAÇÃO ==========

  bool _validateForm() {
    if (_title.trim().isEmpty) {
      _errorMessage = 'O título é obrigatório';
      notifyListeners();
      return false;
    }

    if (_title.trim().length < 2) {
      _errorMessage = 'O título deve ter pelo menos 2 caracteres';
      notifyListeners();
      return false;
    }

    if (_author.trim().isEmpty) {
      _errorMessage = 'O autor é obrigatório';
      notifyListeners();
      return false;
    }

    if (_author.trim().length < 2) {
      _errorMessage = 'O nome do autor deve ter pelo menos 2 caracteres';
      notifyListeners();
      return false;
    }

    if (_selectedGenres.isEmpty) {
      _errorMessage = 'Selecione pelo menos um gênero';
      notifyListeners();
      return false;
    }

    return true;
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // ========== NAVEGAÇÃO ==========

  void clearNavigation() {
    _pendingNavigation = null;
  }

  void onBackPressed() {
    _pendingNavigation = NavigationEvent.pop();
    notifyListeners();
  }

  // ========== AÇÃO PRINCIPAL ==========

  /// Salva o livro e navega de volta
  Future<void> onSaveBook() async {
    if (!_validateForm()) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Gera ID único
      final id = _generateId();

      // Cria o livro
      final book = Book(
        id: id,
        title: _title.trim(),
        author: _author.trim(),
        isbn: _isbn.trim().isEmpty ? null : _isbn.trim(),
        coverUrl: _coverUrl.trim().isEmpty ? null : _coverUrl.trim(),
        description: _description.trim().isEmpty ? null : _description.trim(),
        genres: _selectedGenres,
        owner: currentUser,
        status: BookStatus.available,
        condition: _condition,
        creditsRequired: _creditsRequired,
        language: _language,
        pageCount: _pageCount,
      );

      // Salva no repository
      await _repository.addBook(book);

      // Navega de volta
      _pendingNavigation = NavigationEvent.pop();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao salvar livro: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Gera um ID único para o livro
  String _generateId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'book-$timestamp';
  }
}
