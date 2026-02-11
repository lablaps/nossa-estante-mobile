import '../domain/entities/entities.dart';

/// Mocks de usuários para desenvolvimento e testes
class MockUsers {
  /// Usuário atual (logado)
  static final User currentUser = User(
    id: 'user-001',
    name: 'Você',
    email: 'voce@nossaestante.com',
    credits: 12,
    location: UserLocation(
      latitude: -23.5505,
      longitude: -46.6333,
      address: 'São Paulo, SP',
    ),
  );

  /// Lista de usuários mockados
  static final List<User> users = [
    User(
      id: 'user-002',
      name: 'Ana Silva',
      email: 'ana.silva@email.com',
      credits: 8,
      location: UserLocation(
        latitude: -23.5515,
        longitude: -46.6340,
        address: 'Pinheiros, São Paulo',
      ),
    ),
    User(
      id: 'user-003',
      name: 'Miguel Santos',
      email: 'miguel.santos@email.com',
      credits: 15,
      location: UserLocation(
        latitude: -23.5520,
        longitude: -46.6345,
        address: 'Vila Madalena, São Paulo',
      ),
    ),
    User(
      id: 'user-004',
      name: 'Lucas Oliveira',
      email: 'lucas.oliveira@email.com',
      credits: 20,
      location: UserLocation(
        latitude: -23.5570,
        longitude: -46.6400,
        address: 'Consolação, São Paulo',
      ),
    ),
    User(
      id: 'user-005',
      name: 'Julia Costa',
      email: 'julia.costa@email.com',
      credits: 5,
      location: UserLocation(
        latitude: -23.5630,
        longitude: -46.6550,
        address: 'Paulista, São Paulo',
      ),
    ),
    User(
      id: 'user-006',
      name: 'Pedro Almeida',
      email: 'pedro.almeida@email.com',
      credits: 10,
      location: UserLocation(
        latitude: -23.5700,
        longitude: -46.6800,
        address: 'Jardins, São Paulo',
      ),
    ),
  ];

  /// Busca usuário por ID
  static User? findById(String id) {
    if (id == currentUser.id) return currentUser;
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Retorna todos os usuários incluindo o atual
  static List<User> get all => [currentUser, ...users];
}
