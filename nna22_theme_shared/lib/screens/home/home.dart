import 'package:flutter/material.dart';
import 'package:nna22_theme_shared/shared/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Your Characters'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // use the custom widgets that use custom theme from :file:theme.dart
            const StyledTitle('title - :widget:StyledTitle'),
            const StyledHeading('heading - :widget:StyledHeading'),
            const StyledText('text - :widget:StyledText'),

            FilledButton(
              onPressed: () {
                // navigate to the create screen
              },
              child: const Text('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
