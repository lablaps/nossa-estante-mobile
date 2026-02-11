import 'package:flutter/material.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/signup_page.dart';
import '../../features/app_shell/app_shell_page.dart';
import '../../features/explore/book_details_page.dart';
import '../../features/add_book/add_book_page.dart';
import '../domain/entities/entities.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  // Rotas da Home
  static const String bookDetails = '/book-details';
  static const String nearbyBooks = '/nearby-books';
  static const String notifications = '/notifications';

  // Rotas do Explore
  static const String featured = '/featured';
  static const String collection = '/collection';

  // Rotas do My Shelf
  static const String addBook = '/add-book';

  static Map<String, WidgetBuilder> get routes => {
    onboarding: (context) => const OnboardingPage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    home: (context) => const AppShellPage(),
    // bookDetails usa onGenerateRoute para receber argumentos
    nearbyBooks: (context) => const _PlaceholderPage(title: 'Livros Próximos'),
    notifications: (context) => const _PlaceholderPage(title: 'Notificações'),
    featured: (context) => const _PlaceholderPage(title: 'Em Destaque'),
    // collection usa onGenerateRoute para receber argumentos
    addBook: (context) => const AddBookPage(),
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
        final book = settings.arguments as Book?;
        if (book == null) {
          return MaterialPageRoute(
            builder: (context) =>
                const _PlaceholderPage(title: 'Livro não encontrado'),
          );
        }
        return MaterialPageRoute(
          builder: (context) => BookDetailsPage(book: book),
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
      case featured:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderPage(title: 'Em Destaque'),
        );
      case collection:
        return MaterialPageRoute(
          builder: (context) => const _PlaceholderPage(title: 'Coleção'),
          settings: settings,
        );
      case addBook:
        return MaterialPageRoute(builder: (context) => const AddBookPage());
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
