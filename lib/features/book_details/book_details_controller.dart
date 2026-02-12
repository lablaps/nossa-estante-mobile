import 'package:flutter/material.dart';
import '../../core/routes/navigation_event.dart';
import '../../core/domain/entities/entities.dart';

/// Controller for managing book details page state and navigation
class BookDetailsController with ChangeNotifier {
  NavigationEvent? _pendingNavigation;
  final Book book;
  final User? currentUser;

  BookDetailsController({required this.book, this.currentUser});

  NavigationEvent? get pendingNavigation => _pendingNavigation;

  void clearNavigation() {
    _pendingNavigation = null;
  }

  /// Navigate to user profile
  void navigateToProfile(String userId) {
    _pendingNavigation = NavigationEvent.push('/profile', arguments: userId);
    notifyListeners();
  }

  /// Navigate back to previous screen
  void pop() {
    _pendingNavigation = NavigationEvent.pop();
    notifyListeners();
  }

  /// Handle back button tap
  void onBackTap() {
    pop();
  }

  /// Handle share button tap
  void onShareTap() {
    // TODO: Implementar compartilhamento
  }

  /// Handle message tap to owner
  void onMessageTap() {
    // TODO: Implementar mensagem para dono
  }
}
