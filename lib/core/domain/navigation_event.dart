/// Evento de navegação emitido pelos controllers
///
/// Centraliza o padrão de navegação usado em todas as features.
/// Controllers emitem eventos, UI observa e executa.
class NavigationEvent {
  final String route;
  final Object? arguments;

  NavigationEvent(this.route, {this.arguments});
}
