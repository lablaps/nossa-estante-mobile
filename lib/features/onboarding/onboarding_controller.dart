import 'package:flutter/material.dart';

/// Controller para gerenciar o estado do onboarding
class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 4;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLastPage => _currentPage == _totalPages - 1;

  OnboardingController() {
    pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      _currentPage = page;
      notifyListeners();
    }
  }

  /// Avança para a próxima página
  void nextPage() {
    if (_currentPage < _totalPages - 1) {
      pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Pula o onboarding (vai para a última página)
  void skip() {
    pageController.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();
    super.dispose();
  }
}
