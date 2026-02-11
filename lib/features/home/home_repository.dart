import '../../core/domain/entities/entities.dart';
import '../../core/mocks/mocks.dart';

/// Repository que fornece dados para a Home
///
/// Retorna dados de domínio usando mocks.
/// Futuramente será substituído por chamadas HTTP reais.
class HomeRepository {
  Future<List<Book>> fetchNearbyBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final currentUserLocation = MockUsers.currentUser.location;

    if (currentUserLocation == null) {
      return MockBooks.available.take(4).toList();
    }

    return MockBooks.findNearby(currentUserLocation, limit: 4);
  }

  Future<List<Exchange>> fetchCommunityActivities() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return MockExchanges.getRecentActivity(limit: 5)
        .where(
          (exchange) =>
              exchange.status == ExchangeStatus.completed ||
              exchange.status == ExchangeStatus.approved,
        )
        .toList();
  }
}
