import 'package:flutter/material.dart';
import '../../../core/routes/navigation_event.dart';

/// Controller for managing real book photos state and navigation
class RealBookPhotosController with ChangeNotifier {
  NavigationEvent? _pendingNavigation;

  NavigationEvent? get pendingNavigation => _pendingNavigation;

  void clearNavigation() {
    _pendingNavigation = null;
  }

  /// Navigate to photo viewer page
  void navigateToPhotoViewer(List<String> photos, int initialIndex) {
    _pendingNavigation = NavigationEvent.push(
      '/photo-viewer',
      arguments: {'photos': photos, 'initialIndex': initialIndex},
    );
    notifyListeners();
  }

  /// Navigate back from photo viewer
  void navigateBack() {
    _pendingNavigation = NavigationEvent.pop();
    notifyListeners();
  }
}
