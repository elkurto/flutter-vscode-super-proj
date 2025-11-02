import 'package:flutter/material.dart';
import 'package:nna62_provider_global_state/screens/home/home.dart';
import 'package:nna62_provider_global_state/services/character_store.dart' show CharacterStore;
import 'package:nna62_provider_global_state/theme.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
//import 'package:nna62_provider_global_state/screens/create/create.dart';

void main() {
  runApp(
    // lesson-61 - idiom for using a ChangeNotifierProvider in runApp
    //  so that publishes/uses :ChangeNotifier:CharacterStore
    ChangeNotifierProvider(
      create: (context) => CharacterStore(),
      child: MaterialApp(theme: primaryTheme, home: const Home()),
    ),
  );

  // show create screen for debugging and feedback
  // runApp(MaterialApp(theme: primaryTheme, home: const Create()));
}

// sandbox
class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox'), backgroundColor: Colors.grey),
      body: const Text('sandbox'),
    );
  }
}
