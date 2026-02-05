import 'package:flutter/widgets.dart';
import '../features/home/home_page.dart';

class Routes {
  static const home = '/';
}

final Map<String, WidgetBuilder> routes = {
  Routes.home: (_) => const HomePage(),
};
