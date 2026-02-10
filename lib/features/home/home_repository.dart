import 'package:flutter/material.dart';

/// Repository que fornece dados para a Home
///
/// Por enquanto retorna dados mockados.
/// Futuramente será substituído por chamadas HTTP reais.
class HomeRepository {
  /// Busca livros próximos do usuário
  Future<List<NearbyBook>> fetchNearbyBooks() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      NearbyBook(
        title: 'O Alquimista',
        author: 'Paulo Coelho',
        distance: '0.5km',
        credits: 2,
      ),
      NearbyBook(
        title: 'Sapiens',
        author: 'Yuval Noah Harari',
        distance: '1.2km',
        credits: 3,
      ),
      NearbyBook(
        title: 'Duna',
        author: 'Frank Herbert',
        distance: '2.0km',
        credits: 2,
      ),
      NearbyBook(
        title: '1984',
        author: 'George Orwell',
        distance: '3.5km',
        credits: 1,
      ),
    ];
  }

  /// Busca atividades recentes da comunidade
  Future<List<CommunityActivity>> fetchCommunityActivities() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      CommunityActivity(
        type: ActivityType.exchange,
        text: 'Ana trocou um livro com Miguel',
        time: '15 minutos atrás',
        location: 'Perto',
        icon: Icons.swap_horiz,
        color: const Color(0xFF13EC5B),
      ),
      CommunityActivity(
        type: ActivityType.add,
        text: 'Lucas adicionou 3 novos livros',
        time: '1 hora atrás',
        location: '2km de distância',
        icon: Icons.add_circle,
        color: Colors.blue,
      ),
    ];
  }
}

/// Model de livro próximo
class NearbyBook {
  final String title;
  final String author;
  final String distance;
  final int credits;

  NearbyBook({
    required this.title,
    required this.author,
    required this.distance,
    required this.credits,
  });

  /// Converte para Map (compatibilidade com código existente)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'distance': distance,
      'credits': credits,
    };
  }
}

/// Model de atividade da comunidade
class CommunityActivity {
  final ActivityType type;
  final String text;
  final String time;
  final String location;
  final IconData icon;
  final Color color;

  CommunityActivity({
    required this.type,
    required this.text,
    required this.time,
    required this.location,
    required this.icon,
    required this.color,
  });

  /// Converte para Map (compatibilidade com código existente)
  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'text': text,
      'time': time,
      'location': location,
      'icon': icon,
      'color': color,
    };
  }
}

/// Tipos de atividade da comunidade
enum ActivityType { exchange, add, review, wishlist }
