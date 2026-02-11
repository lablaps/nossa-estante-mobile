import 'package:flutter/material.dart';
import '../../core/routes/navigation_event.dart';

/// Controller para gerenciar o estado do AppShell
class AppShellController extends ChangeNotifier {
  int _currentIndex = 0;
  NavigationEvent? _pendingNavigation;

  int get currentIndex => _currentIndex;
  NavigationEvent? get pendingNavigation => _pendingNavigation;

  /// Atualiza o índice da aba atual
  void setIndex(int index) {
    // Se o índice for 2 (botão adicionar), navega para /add-book
    if (index == 2) {
      _pendingNavigation = NavigationEvent.push('/add-book');
      notifyListeners();
      return;
    }

    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Limpa navegação pendente
  void clearNavigation() {
    _pendingNavigation = null;
  }

  /// Volta para a aba inicial
  void resetToHome() {
    setIndex(0);
  }
}
