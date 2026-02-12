import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';

/// Widget de diálogo para confirmação de resgate de livro
class BookRedeemDialog extends StatelessWidget {
  final Book book;
  final VoidCallback onConfirm;

  const BookRedeemDialog({
    super.key,
    required this.book,
    required this.onConfirm,
  });

  /// Exibe o diálogo de resgate
  static Future<void> show({
    required BuildContext context,
    required Book book,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => BookRedeemDialog(book: book, onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Resgatar Livro'),
      content: Text(
        'Deseja resgatar "${book.title}" por ${book.creditsRequired} créditos?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
