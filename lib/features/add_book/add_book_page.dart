import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import 'add_book_controller.dart';
import 'add_book_repository.dart';
import 'widgets/add_book_form.dart';
import 'widgets/add_book_genre_selector.dart';
import 'widgets/add_book_cover_picker.dart';
import 'widgets/add_book_settings.dart';
import 'widgets/add_book_actions.dart';

/// Página para adicionar um novo livro à estante
///
/// Permite o usuário cadastrar um livro com:
/// - Título e autor (obrigatórios)
/// - ISBN, capa, descrição (opcionais)
/// - Gêneros (pelo menos um obrigatório)
/// - Condição, idioma, número de páginas
/// - Créditos necessários para troca
class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddBookController(repository: AddBookRepository()),
      child: const _AddBookView(),
    );
  }
}

class _AddBookView extends StatefulWidget {
  const _AddBookView();

  @override
  State<_AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<_AddBookView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<AddBookController>();

    // Observa eventos de navegação
    if (controller.pendingNavigation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final navigation = controller.pendingNavigation;
        if (navigation != null && mounted) {
          controller.clearNavigation();
          if (navigation.isPop) {
            Navigator.of(context).pop();
          } else if (navigation.route != null) {
            Navigator.pushNamed(
              context,
              navigation.route!,
              arguments: navigation.arguments,
            );
          }
        }
      });
    }

    // Exibe erro se houver
    if (controller.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(controller.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AddBookController>();

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textColor),
          onPressed: controller.onBackPressed,
        ),
        title: Text('Adicionar Livro', style: AppTextStyles.h4(context)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Conteúdo com scroll
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.paddingPage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Capa do livro
                  AddBookCoverPicker(controller: controller),
                  AppSpacing.verticalXL,

                  // Formulário principal
                  AddBookForm(controller: controller),
                  AppSpacing.verticalXL,

                  // Seletor de gêneros
                  AddBookGenreSelector(controller: controller),
                  AppSpacing.verticalXL,

                  // Configurações de troca
                  AddBookSettings(controller: controller),

                  // Espaço para o botão fixo
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Botão de ação fixo no bottom
          AddBookActions(controller: controller),
        ],
      ),
    );
  }
}
