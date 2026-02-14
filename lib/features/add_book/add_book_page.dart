import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import 'add_book_controller.dart';
import 'add_book_repository.dart';
import 'widgets/isbn_scanner_area.dart';
import 'widgets/validated_text_field.dart';
import 'widgets/condition_selector.dart';
import 'widgets/photo_upload_section.dart';
import 'widgets/category_language_row.dart';
import 'widgets/location_selector.dart';
import 'widgets/exchange_settings_section.dart';

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

    // Handle navigation
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

    // Handle errors
    if (controller.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(controller.errorMessage!),
              backgroundColor: AppColors.statusUnavailable,
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
      body: Column(
        children: [
          // Header
          _buildHeader(context, controller),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: AppSpacing.paddingPage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ISBN Scanner Area
                  if (!controller.isManualEntry)
                    IsbnScannerArea(
                      onTap: () {
                        // Future: Implement scanner
                      },
                    ),
                  if (!controller.isManualEntry) AppSpacing.verticalMD,

                  // Manual entry toggle
                  _buildManualEntryToggle(context, controller),
                  AppSpacing.verticalLG,

                  // Title field
                  ValidatedTextField(
                    label: 'Título',
                    hint: 'ex: O Alquimista',
                    value: controller.title,
                    isValid: controller.isTitleValid,
                    onChanged: controller.setTitle,
                  ),
                  AppSpacing.verticalLG,

                  // Author field
                  ValidatedTextField(
                    label: 'Autor',
                    hint: 'ex: Paulo Coelho',
                    value: controller.author,
                    isValid: controller.isAuthorValid,
                    onChanged: controller.setAuthor,
                  ),
                  AppSpacing.verticalLG,

                  // Category and Language
                  CategoryLanguageRow(
                    selectedCategory: controller.selectedGenres.isEmpty
                        ? null
                        : controller.selectedGenres.first,
                    selectedLanguage: controller.language,
                    onCategoryChanged: (value) {
                      if (value != null) {
                        controller.setGenres([value]);
                      }
                    },
                    onLanguageChanged: controller.setLanguage,
                  ),
                  AppSpacing.verticalLG,

                  // Condition selector
                  ConditionSelector(
                    selectedCondition: controller.condition,
                    onConditionChanged: controller.setCondition,
                  ),
                  AppSpacing.verticalLG,

                  // Photo upload
                  PhotoUploadSection(
                    photos: controller.realBookPhotos,
                    onAddPhoto: () {
                      // Future: Implement photo picker
                      controller.addPhoto('https://via.placeholder.com/150');
                    },
                    onRemovePhoto: controller.removePhoto,
                  ),
                  AppSpacing.verticalLG,

                  // Owner notes
                  _buildOwnerNotesField(context, controller),
                  AppSpacing.verticalLG,

                  // Synopsis
                  ValidatedTextField(
                    label: 'Sinopse',
                    hint: 'Digite a descrição do livro...',
                    value: controller.description,
                    isValid: true,
                    onChanged: controller.setDescription,
                    maxLines: 6,
                  ),
                  AppSpacing.verticalLG,

                  // Exchange settings section
                  ExchangeSettingsSection(
                    locationSelector: LocationSelector(
                      onUseCurrentLocation: () {
                        // Future: Implement location
                      },
                      onSelectOnMap: () {
                        // Future: Implement map picker
                      },
                    ),
                  ),

                  // Bottom padding for button
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating action button
      floatingActionButton: _buildSaveButton(context, controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Header
  Widget _buildHeader(BuildContext context, AddBookController controller) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppSpacing.sm,
        bottom: AppSpacing.sm,
        left: AppSpacing.md,
        right: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: context.isDark ? context.borderColor : AppColors.transparent,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: controller.onBackPressed,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.overlay,
              ),
              child: Icon(
                Icons.arrow_back,
                color: context.textColor,
                size: AppDimensions.iconMD,
              ),
            ),
          ),

          // Title
          Expanded(
            child: Text(
              'Cadastrar Livro',
              style: AppTextStyles.h4(context),
              textAlign: TextAlign.center,
            ),
          ),

          // Spacer to center title
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // Manual entry toggle
  Widget _buildManualEntryToggle(
    BuildContext context,
    AddBookController controller,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: controller.toggleManualEntry,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit,
              color: AppColors.primary,
              size: AppDimensions.iconSM,
            ),
            AppSpacing.horizontalXS,
            Text(
              controller.isManualEntry
                  ? 'Escanear Código'
                  : 'Inserir Manualmente',
              style: AppTextStyles.labelSmall(
                context,
              ).copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Owner notes field
  Widget _buildOwnerNotesField(
    BuildContext context,
    AddBookController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with optional tag
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Observações do Proprietário',
              style: AppTextStyles.labelMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              'Opcional',
              style: AppTextStyles.caption(
                context,
              ).copyWith(color: context.textMuted),
            ),
          ],
        ),
        AppSpacing.verticalSM,

        // Input field
        TextFormField(
          initialValue: controller.ownerNotes,
          onChanged: controller.setOwnerNotes,
          style: AppTextStyles.bodyMedium(context),
          decoration: InputDecoration(
            hintText: 'Mencione marcas, grifos ou danos...',
            hintStyle: AppTextStyles.bodyMedium(
              context,
            ).copyWith(color: context.textMuted),
            filled: true,
            fillColor: context.surfaceColor,
            contentPadding: EdgeInsets.all(AppSpacing.md),
            border: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(color: context.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(color: context.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadiusSM,
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Save button
  Widget _buildSaveButton(BuildContext context, AddBookController controller) {
    return Container(
      width: MediaQuery.of(context).size.width - (AppSpacing.md * 2),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusFull,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: controller.isLoading ? null : controller.onSaveBook,
          borderRadius: AppDimensions.borderRadiusFull,
          child: Center(
            child: controller.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: AppColors.primaryButtonText,
                        size: AppDimensions.iconMD,
                      ),
                      AppSpacing.horizontalSM,
                      Text(
                        'Adicionar à Minha Estante',
                        style: AppTextStyles.h6(
                          context,
                        ).copyWith(color: AppColors.primaryButtonText),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
