import 'package:flutter/material.dart';
import '../../core/domain/navigation_event.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _errorMessage;
  NavigationEvent? _pendingNavigation;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String? get errorMessage => _errorMessage;
  NavigationEvent? get pendingNavigation => _pendingNavigation;

  void clearNavigation() {
    _pendingNavigation = null;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoading = false;
      _pendingNavigation = NavigationEvent('/home');
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Email e senha são obrigatórios';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Simula cadastro mockado
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = 'Todos os campos são obrigatórios';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (password != confirmPassword) {
      _errorMessage = 'As senhas não coincidem';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (password.length < 6) {
      _errorMessage = 'A senha deve ter pelo menos 6 caracteres';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    _pendingNavigation = NavigationEvent('/home');
    notifyListeners();
    return true;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _errorMessage = null;
    _pendingNavigation = null;
    notifyListeners();
  }
}
