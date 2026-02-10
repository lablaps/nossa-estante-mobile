import 'package:flutter/material.dart';

/// Controller para gerenciar o estado da Home
class HomeController extends ChangeNotifier {
  String _selectedFilter = 'Perto de mim';

  String get selectedFilter => _selectedFilter;

  /// Lista de filtros disponíveis
  final List<String> filters = [
    'Perto de mim',
    'Ficção',
    'Biografias',
    'Sci-Fi',
  ];

  /// Altera o filtro selecionado
  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  /// Dados mockados de livros próximos
  List<Map<String, dynamic>> get nearbyBooks => [
    {
      'title': 'O Alquimista',
      'author': 'Paulo Coelho',
      'distance': '0.5km',
      'credits': 2,
    },
    {
      'title': 'Sapiens',
      'author': 'Yuval Noah Harari',
      'distance': '1.2km',
      'credits': 3,
    },
    {
      'title': 'Duna',
      'author': 'Frank Herbert',
      'distance': '2.0km',
      'credits': 2,
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'distance': '3.5km',
      'credits': 1,
    },
  ];

  /// Dados mockados de atividades da comunidade
  List<Map<String, dynamic>> get communityActivities => [
    {
      'type': 'exchange',
      'text': 'Ana trocou um livro com Miguel',
      'time': '15 minutos atrás',
      'location': 'Perto',
      'icon': Icons.swap_horiz,
      'color': Color(0xFF13EC5B),
    },
    {
      'type': 'add',
      'text': 'Lucas adicionou 3 novos livros',
      'time': '1 hora atrás',
      'location': '2km de distância',
      'icon': Icons.add_circle,
      'color': Colors.blue,
    },
  ];
}
