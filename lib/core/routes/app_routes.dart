import 'package:flutter/material.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/signup_page.dart';
import '../../features/app_shell/app_shell_page.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  // Rotas da Home
  static const String bookDetails = '/book-details';
  static const String nearbyBooks = '/nearby-books';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> get routes => {
    onboarding: (context) => const OnboardingPage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    home: (context) => const AppShellPage(),
    bookDetails: (context) =>
        const _PlaceholderPage(title: 'Detalhes do Livro'),
    nearbyBooks: (context) => const _PlaceholderPage(title: 'Livros Próximos'),
    notifications: (context) => const _PlaceholderPage(title: 'Notificações'),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingPage());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignupPage());
      case home:
        return MaterialPageRoute(builder: (context) => const AppShellPage());
      case bookDetails:
        return MaterialPageRoute(
          builder: (context) =>
              const _PlaceholderPage(title: 'Detalhes do Livro'),
          settings: settings,
        );
      case nearbyBooks:
        return MaterialPageRoute(
          builder: (context) =>
              const _PlaceholderPage(title: 'Livros Próximos'),
        );
      case notifications:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderPage(title: 'Notificações'),
        );
      default:
        return null;
    }
  }
}

/// Página placeholder para rotas ainda não implementadas
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Em construção',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
