import 'package:flutter/material.dart';
import 'package:nna24_container_gradient/shared/styled_text.dart';
import 'package:nna24_container_gradient/shared/styled_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Your Characters - :font:kanit'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const StyledTitle('title - StyledTitle, :font:kanit'),
            const StyledHeading('heading - StyledHeading, :font:kanit'),
            const StyledText('text - :StyledText, font:kanit'),

            StyledButton(
              onPressed: () {
                // @todo: navigate to the create screen
              },
              child: StyledHeading('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
