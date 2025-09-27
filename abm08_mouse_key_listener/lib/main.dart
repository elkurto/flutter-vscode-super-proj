import 'package:abm08_mouse_key_listener/gamescreenwidget.dart' show GameScreenWidget;
import 'package:abm08_mouse_key_listener/homescreenwidget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  //runApp(const MyApp(appTitle: 'abm08_mouse_key_listener'));
  runApp(OuterRouterAppWidget());
}

class OuterRouterAppWidget extends StatelessWidget {
  OuterRouterAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'abm08_mouse_key_listener',
      debugShowCheckedModeBanner: false,
    );
  }

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (BuildContext buildContenxt, GoRouterState goRouterState) {
          return const HomeScreenWidget();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'game',
            path: 'game',
            builder: (BuildContext buildContext, GoRouterState goRouterState) {
              return const GameScreenWidget();
            },
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        backgroundColor: Colors.red,
        body: Center(child: const GameScreenWidget()),
      ),
    );
  }
}
