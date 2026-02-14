import 'package:flutter/material.dart';
import '../../core/domain/entities/entities.dart';
import '../../core/routes/navigation_event.dart';
import '../../core/mocks/mock_users.dart';
import 'add_book_repository.dart';

class AddBookController extends ChangeNotifier {
  final AddBookRepository _repository;

  AddBookController({required AddBookRepository repository})
    : _repository = repository;

  String _title = '';
  String _author = '';
  String _isbn = '';
  String _coverUrl = '';
  String _description = '';
  String _ownerNotes = '';
  List<String> _selectedGenres = [];
  List<String> _realBookPhotos = [];
  int _creditsRequired = 1;
  BookCondition _condition = BookCondition.new_;
  String? _language;
  int? _pageCount;
  bool _isManualEntry = false;

  bool _isLoading = false;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;
  User get currentUser => MockUsers.currentUser;

  String get title => _title;
  String get author => _author;
  String get isbn => _isbn;
  String get coverUrl => _coverUrl;
  String get description => _description;
  String get ownerNotes => _ownerNotes;
  List<String> get selectedGenres => _selectedGenres;
  List<String> get realBookPhotos => _realBookPhotos;
  int get creditsRequired => _creditsRequired;
  BookCondition get condition => _condition;
  String? get language => _language;
  int? get pageCount => _pageCount;
  bool get isManualEntry => _isManualEntry;

  bool get isTitleValid => _title.trim().isNotEmpty;
  bool get isAuthorValid => _author.trim().isNotEmpty;

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

  void setOwnerNotes(String value) {
    _ownerNotes = value;
    _clearError();
  }

  void toggleManualEntry() {
    _isManualEntry = !_isManualEntry;
    notifyListeners();
  }

  void addPhoto(String photoUrl) {
    if (_realBookPhotos.length < 4) {
      _realBookPhotos = [..._realBookPhotos, photoUrl];
      notifyListeners();
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < _realBookPhotos.length) {
      _realBookPhotos = List.from(_realBookPhotos)..removeAt(index);
      notifyListeners();
    }
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

  void clearNavigation() {
    _pendingNavigation = null;
  }

  void onBackPressed() {
    _pendingNavigation = NavigationEvent.pop();
    notifyListeners();
  }

  Future<void> onSaveBook() async {
    if (!_validateForm()) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final id = _generateId();

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
        realBookPhotos: _realBookPhotos,
        language: _language,
        pageCount: _pageCount,
      );

      await _repository.addBook(book);

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

  String _generateId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'book-$timestamp';
  }
}
