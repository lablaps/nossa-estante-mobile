import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
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

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (controller.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(controller.errorMessage!),
            backgroundColor: AppColors.primaryDark,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(color: context.surfaceColor),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Header
                      const AuthHeader(
                        title: 'Bem-vindo de volta',
                        subtitle: 'Faça login para continuar trocando livros',
                      ),
                      _buildForm(),
                      _buildDivider(),
                      _buildSocialLogin(),
                      const Spacer(),
                      _buildFooter(),
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

  Widget _buildForm() {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: AppSpacing.paddingForm,
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'Endereço de email',
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
                AppSpacing.verticalLG,

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
                      color: context.textMuted,
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
                AppSpacing.verticalSM,

                // Link esqueci a senha
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidade em desenvolvimento'),
                        ),
                      );
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(
                        color: context.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                AppSpacing.verticalSM,

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

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: context.borderColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              'Ou continue com',
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(color: context.textMuted),
            ),
          ),
          Expanded(child: Container(height: 1, color: context.borderColor)),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Padding(
      padding: AppSpacing.paddingHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialLoginButton(
            icon: Icons.g_mobiledata_rounded,
            tooltip: 'Continuar com Google',
            onPressed: () {},
          ),
          const SizedBox(width: AppSpacing.md),
          SocialLoginButton(
            icon: Icons.apple_rounded,
            tooltip: 'Continuar com Apple',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Rodapé com link para cadastro
  Widget _buildFooter() {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return Container(
          margin: const EdgeInsets.only(top: AppSpacing.xl),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
          decoration: BoxDecoration(
            color: context.backgroundColor.withOpacity(0.5),
            border: Border(
              top: BorderSide(
                color: context.borderColor,
              ),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não tem uma conta? ',
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(color: context.textMuted),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Cadastre-se',
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
