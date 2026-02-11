import '../domain/entities/entities.dart';

/// Utilitários para formatação de distância
class DistanceFormatter {
  DistanceFormatter._();

  /// Formata distância entre duas localizações
  ///
  /// Retorna string formatada baseada na distância em km:
  /// - < 1km: retorna metros (ex: "250m")
  /// - >= 1km: retorna km com 1 casa decimal (ex: "2.5km")
  /// - Se alguma localização for null: retorna [fallback]
  static String format(
    UserLocation? from,
    UserLocation? to, {
    String fallback = 'Longe',
  }) {
    if (from == null || to == null) {
      return fallback;
    }

    final distanceKm = from.distanceTo(to);

    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()}m';
    } else {
      return '${distanceKm.toStringAsFixed(1)}km';
    }
  }

  /// Formata distância com texto descritivo
  ///
  /// Retorna:
  /// - < 1km: "Perto"
  /// - 1-5km: "X.Xkm de distância"
  /// - > 5km: "Longe"
  static String formatWithDescription(
    UserLocation? from,
    UserLocation? to, {
    String fallback = 'Local não definido',
  }) {
    if (from == null || to == null) {
      return fallback;
    }

    final distanceKm = from.distanceTo(to);

    if (distanceKm < 1) {
      return 'Perto';
    } else if (distanceKm < 5) {
      return '${distanceKm.toStringAsFixed(1)}km de distância';
    } else {
      return 'Longe';
    }
  }
}
