import 'package:flutter/widgets.dart';
import 'package:hersbruck_together/features/home/home_page.dart';
import 'package:hersbruck_together/features/start/start_page.dart';

class Routes {
  static const start = '/';
  static const home = '/home';
}

final Map<String, WidgetBuilder> routes = {
  Routes.start: (_) => const StartPage(),
  Routes.home: (_) => const HomePage(),
};

/// Route generator for routes that need parameters
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == Routes.home) {
    final args = settings.arguments as Map<String, dynamic>?;
    final initialTabIndex = args?['initialTabIndex'] as int? ?? 0;
    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(
        initialTabIndex: initialTabIndex,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
  return null;
}
