/// Represents a navigation event in the application
class NavigationEvent {
  final String? route;
  final Object? arguments;
  final NavigationType type;

  const NavigationEvent._({this.route, this.arguments, required this.type});

  /// Creates a navigation event for pushing a new route
  factory NavigationEvent.push(String route, {Object? arguments}) {
    return NavigationEvent._(
      route: route,
      arguments: arguments,
      type: NavigationType.push,
    );
  }

  /// Creates a navigation event for popping the current route
  factory NavigationEvent.pop() {
    return const NavigationEvent._(type: NavigationType.pop);
  }

  /// Whether this navigation event is a pop action
  bool get isPop => type == NavigationType.pop;

  /// Whether this navigation event is a push action
  bool get isPush => type == NavigationType.push;
}

/// Types of navigation actions
enum NavigationType { push, pop }
