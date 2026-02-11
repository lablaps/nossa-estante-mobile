import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository que fornece dados para a Home
///
/// Retorna dados de domínio usando mocks.
/// Futuramente será substituído por chamadas HTTP reais.
class HomeRepository {
  /// Busca livros próximos do usuário
  ///
  /// Retorna livros ordenados por distância da localização do usuário atual
  Future<List<Book>> fetchNearbyBooks() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));

    final currentUserLocation = MockUsers.currentUser.location;

    if (currentUserLocation == null) {
      // Se não tiver localização, retorna livros disponíveis
      return MockBooks.available.take(4).toList();
    }

    // Retorna livros próximos da localização do usuário
    return MockBooks.findNearby(currentUserLocation, limit: 4);
  }

  /// Busca atividades recentes da comunidade
  ///
  /// Retorna trocas (exchanges) recentes que representam
  /// atividades na comunidade
  Future<List<Exchange>> fetchCommunityActivities() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));

    // Retorna apenas trocas completadas ou aprovadas recentes
    return MockExchanges.getRecentActivity(limit: 5)
        .where(
          (exchange) =>
              exchange.status == ExchangeStatus.completed ||
              exchange.status == ExchangeStatus.approved,
        )
        .toList();
  }
}
