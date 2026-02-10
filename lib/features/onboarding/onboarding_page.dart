import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/page_indicator.dart';
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
            // Header: Skip Button
            _buildHeader(),

            // Main Content: PageView
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

            // Footer: Navigation Controls
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  /// Header com botão Skip
  Widget _buildHeader() {
    // Não exibe o Skip na última página
    if (_controller.isLastPage) {
      return const SizedBox(height: 80);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: _controller.skip,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textMuted,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text(
            'Pular',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  /// Footer com indicadores e botão de navegação
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page Indicators
          PageIndicator(
            currentIndex: _controller.currentPage,
            pageCount: _controller.totalPages,
          ),

          // Next/Get Started Button
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

  /// Tela 1: Discover Books Near You
  Widget _buildPage1() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.map_outlined,
          size: 120,
          color: AppColors.primary.withOpacity(0.3),
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

  /// Tela 2: Scan and Register Books
  Widget _buildPage2() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.qr_code_scanner_outlined,
          size: 120,
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      title: const _OnboardingTitle(mainText: 'Escaneie e Cadastre Livros'),
      description:
          'Use sua câmera para escanear códigos ISBN e adicionar livros em segundos.',
    );
  }

  /// Tela 3: Exchange with Confidence
  Widget _buildPage3() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.people_outline,
          size: 120,
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      title: const _OnboardingTitle(
        mainText: 'Troque com',
        highlightText: 'Confiança',
      ),
      description: 'Converse com usuários e organize trocas seguras.',
    );
  }

  /// Tela 4: Earn Credits by Trading
  Widget _buildPage4() {
    return _OnboardingPageContent(
      imagePlaceholder: _buildImagePlaceholder(
        height: 320,
        child: Icon(
          Icons.stars,
          size: 120,
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      title: const _OnboardingTitle(mainText: 'Ganhe Créditos Trocando'),
      description:
          'Troque livros que você leu para ganhar créditos e descobrir sua próxima história favorita.',
      actionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hero Illustration
          imagePlaceholder,

          const SizedBox(height: 32),

          // Title
          title,

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.slate400
                  : AppColors.slate600,
            ),
          ),

          // Action Button (only on last page)
          if (actionButton != null) ...[
            const SizedBox(height: 32),
            actionButton!,
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Widget de título do onboarding
class _OnboardingTitle extends StatelessWidget {
  final String mainText;
  final String? highlightText;

  const _OnboardingTitle({required this.mainText, this.highlightText});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: -0.5,
          color: isDark ? AppColors.white : AppColors.textMain,
        ),
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
