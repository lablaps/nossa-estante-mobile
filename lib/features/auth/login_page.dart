import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/social_login_button.dart';
import 'auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(AuthController controller) async {
    if (_formKey.currentState!.validate()) {
      final success = await controller.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted && success) {
        // Navega para o AppShell (não permite voltar para login)
        Navigator.pushReplacementNamed(context, '/home');
      } else if (mounted && controller.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(controller.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _buildHeader(isDark),
                      _buildForm(isDark),
                      _buildDivider(isDark),
                      _buildSocialLogin(),
                      const Spacer(),
                      _buildFooter(isDark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 24, left: 16, right: 16),
      child: Column(
        children: [
          // Logo/Ícone
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Título
          Text(
            'Bem-vindo de volta',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textLight : AppColors.textMain,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtítulo
          Text(
            'Faça login para continuar trocando livros',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildForm(bool isDark) {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Campo Email
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Digite seu email',
                  prefixIcon: Icons.mail_outline_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu email';
                    }
                    if (!value.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Senha
                CustomTextField(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: _passwordController,
                  obscureText: !controller.isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: isDark
                          ? AppColors.textMutedLight
                          : AppColors.textMuted,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // Esqueceu a senha
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implementar recuperação de senha
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidade em desenvolvimento'),
                        ),
                      );
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textMutedLight
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Botão Entrar
                PrimaryButton(
                  text: 'Entrar',
                  onPressed: () => _handleLogin(controller),
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ou continue com',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialLoginButton(
            icon: Icons.g_mobiledata_rounded,
            tooltip: 'Continuar com Google',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login com Google em desenvolvimento'),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          SocialLoginButton(
            icon: Icons.apple_rounded,
            tooltip: 'Continuar com Apple',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login com Apple em desenvolvimento'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundDark.withOpacity(0.5)
            : AppColors.backgroundLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.surfaceDark : const Color(0xFFF0F5F1),
          ),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem uma conta? ',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.textMutedLight : AppColors.textMuted,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                'Cadastre-se',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
