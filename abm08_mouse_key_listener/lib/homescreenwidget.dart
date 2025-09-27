import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The home screen that shows a start button.
class HomeScreenWidget extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('abm08')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => buildContext.go(buildContext.namedLocation('game')),
          child: const Text('Play the game!'),
        ),
      ),
    );
  }
}
