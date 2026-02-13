import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/theme.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/gacha_screen.dart';
import 'ui/screens/naming_screen.dart';
import 'ui/screens/dashboard_screen.dart';
import 'ui/screens/create_memo_screen.dart';
import 'ui/screens/settings_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _) => const SplashScreen(),
    ),
    GoRoute(
      path: '/gacha',
      builder: (_, _) => const GachaScreen(),
    ),
    GoRoute(
      path: '/naming',
      builder: (_, _) => const NamingScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (_, _) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/create-memo',
      builder: (_, _) => const CreateMemoScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (_, _) => const SettingsScreen(),
    ),
  ],
);

class PetMemoApp extends StatelessWidget {
  const PetMemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PetMemo',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
