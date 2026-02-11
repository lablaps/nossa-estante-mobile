import '../domain/entities/entities.dart';
import 'mock_users.dart';
import 'mock_books.dart';

/// Mocks de trocas para desenvolvimento e testes
class MockExchanges {
  /// Lista de trocas mockadas
  static final List<Exchange> exchanges = [
    // Troca recente - Ana trocou com Miguel
    Exchange(
      id: 'exchange-001',
      requester: MockUsers.users[0], // Ana Silva
      owner: MockUsers.users[1], // Miguel Santos
      book: MockBooks.books[1], // Sapiens
      status: ExchangeStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      completedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      meetingLocation: 'Shopping Pinheiros',
    ),
    // Troca recente - Lucas adicionou livros (simulada como exchange)
    Exchange(
      id: 'exchange-002',
      requester: MockUsers.currentUser,
      owner: MockUsers.users[2], // Lucas Oliveira
      book: MockBooks.books[2], // Duna
      status: ExchangeStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      meetingLocation: 'Próximo ao metrô Consolação',
    ),
    // Troca em andamento
    Exchange(
      id: 'exchange-003',
      requester: MockUsers.users[3], // Julia Costa
      owner: MockUsers.currentUser,
      book: MockBooks.books[0], // O Alquimista (se o usuário tivesse)
      status: ExchangeStatus.approved,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      meetingLocation: 'Café na Paulista',
    ),
    // Troca antiga - completada
    Exchange(
      id: 'exchange-004',
      requester: MockUsers.users[4], // Pedro Almeida
      owner: MockUsers.users[0], // Ana Silva
      book: MockBooks.books[5], // A Culpa é das Estrelas
      status: ExchangeStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      meetingLocation: 'Parque Ibirapuera',
    ),
    // Troca cancelada
    Exchange(
      id: 'exchange-005',
      requester: MockUsers.users[1], // Miguel Santos
      owner: MockUsers.users[4], // Pedro Almeida
      book: MockBooks.books[4], // O Senhor dos Anéis
      status: ExchangeStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      notes: 'Horários não bateram',
    ),
  ];

  /// Busca troca por ID
  static Exchange? findById(String id) {
    try {
      return exchanges.firstWhere((exchange) => exchange.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Busca trocas por status
  static List<Exchange> findByStatus(ExchangeStatus status) {
    return exchanges.where((exchange) => exchange.status == status).toList();
  }

  /// Busca trocas de um usuário (como solicitante ou dono)
  static List<Exchange> findByUser(String userId) {
    return exchanges
        .where(
          (exchange) =>
              exchange.requester.id == userId || exchange.owner.id == userId,
        )
        .toList();
  }

  /// Retorna atividades recentes da comunidade
  /// Ordenadas por data (mais recente primeiro)
  static List<Exchange> getRecentActivity({int limit = 10}) {
    final recentExchanges = List<Exchange>.from(exchanges);
    recentExchanges.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return recentExchanges.take(limit).toList();
  }

  /// Retorna trocas completadas recentemente
  static List<Exchange> getRecentlyCompleted({int limit = 5}) {
    return exchanges
        .where(
          (exchange) =>
              exchange.status == ExchangeStatus.completed &&
              exchange.completedAt != null,
        )
        .toList()
      ..sort((a, b) => b.completedAt!.compareTo(a.completedAt!))
      ..take(limit);
  }
}
