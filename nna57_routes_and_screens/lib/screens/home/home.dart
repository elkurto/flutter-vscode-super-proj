import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/models/character.dart';
import 'package:nna57_routes_and_screens/screens/home/character_card.dart';
import 'package:nna57_routes_and_screens/shared/styled_button.dart';
import 'package:nna57_routes_and_screens/shared/styled_text.dart';
import 'package:nna57_routes_and_screens/screens/create/create.dart';

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
            // list of characters
            Expanded(
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (_, index) {
                  return CharacterCard(characters[index]);
                },
              ),
            ),

            StyledButton(
              // lesson-47 - push :widget:Create on Navigator's stack
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Create()));
              },
              child: const StyledHeading('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
