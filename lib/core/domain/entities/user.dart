/// Entidade de domínio: Usuário
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final int credits;
  final UserLocation? location;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.credits,
    this.location,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    int? credits,
    UserLocation? location,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      credits: credits ?? this.credits,
      location: location ?? this.location,
    );
  }
}

/// Localização do usuário
class UserLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  /// Calcula distância aproximada em km para outra localização
  /// Usa fórmula simplificada (Haversine)
  double distanceTo(UserLocation other) {
    const earthRadiusKm = 6371.0;

    final dLat = _toRadians(other.latitude - latitude);
    final dLon = _toRadians(other.longitude - longitude);

    final lat1Rad = _toRadians(latitude);
    final lat2Rad = _toRadians(other.latitude);

    final a =
        _sin(dLat / 2) * _sin(dLat / 2) +
        _cos(lat1Rad) * _cos(lat2Rad) * _sin(dLon / 2) * _sin(dLon / 2);

    final c = 2 * _asin(_sqrt(a));

    return earthRadiusKm * c;
  }

  double _toRadians(double degrees) => degrees * 3.141592653589793 / 180.0;
  double _sin(double x) =>
      x - (x * x * x) / 6 + (x * x * x * x * x) / 120; // Aproximação Taylor
  double _cos(double x) => 1 - (x * x) / 2 + (x * x * x * x) / 24;
  double _asin(double x) => x + (x * x * x) / 6 + (3 * x * x * x * x * x) / 40;
  double _sqrt(double x) {
    if (x == 0) return 0;
    double guess = x / 2;
    for (int i = 0; i < 10; i++) {
      guess = (guess + x / guess) / 2;
    }
    return guess;
  }
}
