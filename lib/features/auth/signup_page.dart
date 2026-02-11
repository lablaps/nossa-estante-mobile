import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';
import 'auth_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup(AuthController controller) async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Você precisa aceitar os Termos de Uso e Política de Privacidade',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final success = await controller.signup(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      if (mounted && success) {
        // Navega para o AppShell
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
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: context.backgroundColor,
            child: Stack(
              children: [
                // Elementos decorativos de fundo
                _buildBackgroundDecorations(),

                // Conteúdo principal
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          size.height - MediaQuery.of(context).padding.top,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: AppSpacing.paddingPage,
                        child: Column(
                          children: [
                            const AuthHeader(
                              title: 'Criar conta',
                              subtitle:
                                  'Junte-se à comunidade de troca de livros',
                            ),
                            AppSpacing.verticalLG,
                            _buildForm(),
                            const Spacer(),
                            _buildFooter(),
                            AppSpacing.verticalMD,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -80,
          child: Container(
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(AppDimensions.opacityLow),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Nome completo',
                prefixIcon: Icons.person_outline_rounded,
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu nome';
                  }
                  if (value.length < 3) {
                    return 'Nome deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMD,

              CustomTextField(
                hintText: 'Email',
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
              AppSpacing.verticalMD,

              CustomTextField(
                hintText: 'Senha',
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
                  if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMD,

              CustomTextField(
                hintText: 'Confirmar senha',
                prefixIcon: Icons.lock_reset_rounded,
                controller: _confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: context.textMuted,
                  ),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMD,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  AppSpacing.horizontalSM,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _acceptedTerms = !_acceptedTerms;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.labelMedium(
                            context,
                          ).copyWith(color: context.textMuted),
                          children: [
                            const TextSpan(text: 'Concordo com os '),
                            TextSpan(
                              text: 'Termos de Uso',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: ' e '),
                            TextSpan(
                              text: 'Política de Privacidade',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalLG,

              PrimaryButton(
                text: 'Criar conta',
                onPressed: () => _handleSignup(controller),
                isLoading: controller.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Já tem uma conta? ',
            style: AppTextStyles.bodyMedium(
              context,
            ).copyWith(color: context.textColor),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Entrar',
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
