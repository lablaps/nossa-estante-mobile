import 'user.dart';

/// Entidade de domínio: Transação de créditos
class Transaction {
  final String id;
  final User user;
  final TransactionType type;
  final int amount; // Positivo para ganho, negativo para uso
  final String description;
  final DateTime createdAt;
  final String? relatedEntityId; // ID de Exchange, Review, etc

  const Transaction({
    required this.id,
    required this.user,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    this.relatedEntityId,
  });

  Transaction copyWith({
    String? id,
    User? user,
    TransactionType? type,
    int? amount,
    String? description,
    DateTime? createdAt,
    String? relatedEntityId,
  }) {
    return Transaction(
      id: id ?? this.id,
      user: user ?? this.user,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
    );
  }
}

/// Tipos de transação
enum TransactionType {
  exchangeCompleted, // Créditos ganhos por troca
  exchangeRequested, // Créditos gastos para solicitar troca
  reviewSubmitted, // Créditos ganhos por avaliar
  bookAdded, // Créditos ganhos por adicionar livro
  initialBonus, // Bônus inicial ao criar conta
}
