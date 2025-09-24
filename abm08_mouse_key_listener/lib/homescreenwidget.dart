import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The home screen that shows a start button.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: ListView(
        children: <Widget>[
          // make a :widget:ListTile
          for (final MapEntry<String, Artist> entry in mapIdArtist.entries)
            ListTile(
              title: Text(entry.value.name),
              onTap: () => context.go(
                context.namedLocation(
                  'artist',
                  pathParameters: <String, String>{'artistid': entry.key.toString()},
                ),
              ),
            ),
        ],
      ),
    );
  }
}
