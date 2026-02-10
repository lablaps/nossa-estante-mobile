import 'package:flutter/material.dart';

/// Controller para gerenciar o estado das telas de autenticação
class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String? get errorMessage => _errorMessage;

  /// Alterna visibilidade da senha
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Alterna visibilidade da confirmação de senha
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  /// Simula login mockado
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simula delay de API
    await Future.delayed(const Duration(seconds: 2));

    // Mock: qualquer email/senha funciona
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoading = false;
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

    // Simula delay de API
    await Future.delayed(const Duration(seconds: 2));

    // Validações básicas
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

    // Mock: cadastro sempre funciona se passar validações
    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Limpa mensagem de erro
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset do estado
  void reset() {
    _isLoading = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    _errorMessage = null;
    notifyListeners();
  }
}
