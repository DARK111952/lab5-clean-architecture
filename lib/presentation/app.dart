import 'package:flutter/material.dart';

import '../core/app_config.dart';
import 'screens/home_screen.dart';

/// Кореневий віджет застосунку (тема та головний екран).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
