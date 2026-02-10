import 'package:flutter/material.dart';

/// Controller para gerenciar o estado do AppShell
class AppShellController extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Atualiza o índice da aba atual
  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Volta para a aba inicial
  void resetToHome() {
    setIndex(0);
  }
}
