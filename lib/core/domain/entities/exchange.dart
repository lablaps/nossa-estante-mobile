import 'package:flutter/material.dart';
import 'book.dart';
import 'user.dart';

/// Entidade de domínio: Troca de livros
class Exchange {
  final String id;
  final User requester; // Usuário que solicitou a troca
  final User owner; // Dono do livro
  final Book book; // Livro sendo trocado
  final ExchangeStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? meetingLocation;
  final String? notes;

  const Exchange({
    required this.id,
    required this.requester,
    required this.owner,
    required this.book,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.meetingLocation,
    this.notes,
  });

  Exchange copyWith({
    String? id,
    User? requester,
    User? owner,
    Book? book,
    ExchangeStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? meetingLocation,
    String? notes,
  }) {
    return Exchange(
      id: id ?? this.id,
      requester: requester ?? this.requester,
      owner: owner ?? this.owner,
      book: book ?? this.book,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      meetingLocation: meetingLocation ?? this.meetingLocation,
      notes: notes ?? this.notes,
    );
  }

  /// Retorna o tempo decorrido desde a criação
  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'agora';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''} atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''} atrás';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dia${difference.inDays > 1 ? 's' : ''} atrás';
    } else {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks semana${weeks > 1 ? 's' : ''} atrás';
    }
  }

  /// Retorna dados visuais para exibição da atividade
  ActivityVisualData getVisualData() {
    switch (status) {
      case ExchangeStatus.completed:
        return ActivityVisualData(
          icon: Icons.swap_horiz,
          color: const Color(0xFF13EC5B),
          text: '$requester.name trocou um livro com ${owner.name}',
        );
      case ExchangeStatus.approved:
        return ActivityVisualData(
          icon: Icons.check_circle,
          color: Colors.blue,
          text: '${requester.name} vai trocar com ${owner.name}',
        );
      case ExchangeStatus.pending:
        return ActivityVisualData(
          icon: Icons.pending,
          color: Colors.orange,
          text: '${requester.name} solicitou "${book.title}"',
        );
      case ExchangeStatus.cancelled:
        return ActivityVisualData(
          icon: Icons.cancel,
          color: Colors.grey,
          text: 'Troca de "${book.title}" cancelada',
        );
    }
  }
}

/// Status da troca
enum ExchangeStatus {
  pending, // Aguardando aprovação do dono
  approved, // Aprovada, aguardando encontro
  completed, // Troca realizada com sucesso
  cancelled, // Cancelada por alguma das partes
}

/// Dados visuais de uma atividade
class ActivityVisualData {
  final IconData icon;
  final Color color;
  final String text;

  ActivityVisualData({
    required this.icon,
    required this.color,
    required this.text,
  });
}
