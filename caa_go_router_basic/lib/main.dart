import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
based on go_router basic example
 https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/main.dart

 Shows an app with two screens;
  - '/' -> HomeScreen
  - '/details' -> DetailsScreen

 The first route '/' is mapped to [HomeScreen], and the second route
 '/details' is mapped to [DetailsScreen].

 The buttons use context.go() to navigate to each destination. On mobile
 devices, each destination is deep-linkable and on the web, can be navigated
 to using the address bar.
*/
void main() => runApp(const MyApp());

/// The route configuration.
/// 1. define a global :GoRouter:_router
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:
          _router, // 2. create and return an MaterialApp that uses :GoRouter:_router
      debugShowCheckedModeBanner: false, // no debug banner
    );
  }
}

/// 1.a. define the home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details'),
          child: const Text('Go to the Details screen'),
        ),
      ),
    );
  }
}

/// 1.b define the details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
