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

  static Map<String, WidgetBuilder> get routes => {
    onboarding: (context) => const OnboardingPage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
    home: (context) => const AppShellPage(),
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
      default:
        return null;
    }
  }
}
