import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

class HersbruckTogetherApp extends StatelessWidget {
  const HersbruckTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hersbruck Together',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: routes,
    );
  }
}
