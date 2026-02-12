import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import 'onboarding_controller.dart';

/// Página de Onboarding do aplicativo Nossa Estante
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleComplete() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: PageView(
                controller: _controller.pageController,
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                  _buildPage4(),
                ],
              ),
            ),

            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Não exibe o Skip na última página
    if (_controller.isLastPage) {
      return const SizedBox(height: 80);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xxl,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: _controller.skip,
          style: TextButton.styleFrom(
            foregroundColor: context.textMuted,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
          ),
          child: Text(
            'Pular',
            style: AppTextStyles.labelMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xxl,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PageIndicator(
            currentIndex: _controller.currentPage,
            pageCount: _controller.totalPages,
          ),

          if (_controller.isLastPage)
            const SizedBox.shrink()
          else
            CircularIconButton(
              onPressed: _controller.nextPage,
              icon: Icons.arrow_forward,
            ),
        ],
      ),
    );
  }

  /// Tela 1 do onboarding
  Widget _buildPage1() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.map_outlined,
          size: 120,
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
        ),
      ),
      title: const _OnboardingTitle(
        mainText: 'Descubra Livros',
        highlightText: 'Perto de Você',
      ),
      description:
          'Encontre livros disponíveis para troca perto de você usando o mapa.',
    );
  }

  /// Tela 2 do onboarding
  Widget _buildPage2() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.qr_code_scanner_outlined,
          size: 120,
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
        ),
      ),
      title: const _OnboardingTitle(mainText: 'Escaneie e Cadastre Livros'),
      description:
          'Use sua câmera para escanear códigos ISBN e adicionar livros em segundos.',
    );
  }

  /// Tela 3 do onboarding
  Widget _buildPage3() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.people_outline,
          size: 120,
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
        ),
      ),
      title: const _OnboardingTitle(
        mainText: 'Troque com',
        highlightText: 'Confiança',
      ),
      description: 'Converse com usuários e organize trocas seguras.',
    );
  }

  /// Tela 4 do onboarding
  Widget _buildPage4() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.stars,
          size: 120,
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
        ),
      ),
      title: const _OnboardingTitle(mainText: 'Ganhe Créditos Trocando'),
      description:
          'Troque livros que você leu para ganhar créditos e descobrir sua próxima história favorita.',
      actionButton: Padding(
        padding: AppSpacing.paddingPage,
        child: PrimaryButton(text: 'Começar', onPressed: _handleComplete),
      ),
    );
  }

  /// Widget de placeholder para imagem
  Widget _buildImagePlaceholder({
    required double height,
    required Widget child,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: AppDimensions.borderRadiusXL,
      ),
      child: Center(child: child),
    );
  }
}

/// Widget de conteúdo de cada página do onboarding
class _OnboardingPageContent extends StatelessWidget {
  final Widget imagePlaceholder;
  final Widget title;
  final String description;
  final Widget? actionButton;

  const _OnboardingPageContent({
    required this.imagePlaceholder,
    required this.title,
    required this.description,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hero Illustration
          imagePlaceholder,

          AppSpacing.verticalXXL,

          // Title
          title,

          AppSpacing.verticalMD,

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge(
              context,
            ).copyWith(height: 1.5, color: context.textMuted),
          ),

          if (actionButton != null) ...[AppSpacing.verticalXXL, actionButton!],

          AppSpacing.verticalLG,
        ],
      ),
    );
  }
}

/// Título do onboarding
class _OnboardingTitle extends StatelessWidget {
  final String mainText;
  final String? highlightText;

  const _OnboardingTitle({required this.mainText, this.highlightText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.h1(
          context,
        ).copyWith(height: 1.1, letterSpacing: -0.5, color: context.textColor),
        children: [
          TextSpan(text: mainText),
          if (highlightText != null) ...[
            const TextSpan(text: '\n'),
            TextSpan(
              text: highlightText,
              style: const TextStyle(color: AppColors.primary),
            ),
          ],
        ],
      ),
    );
  }
}
