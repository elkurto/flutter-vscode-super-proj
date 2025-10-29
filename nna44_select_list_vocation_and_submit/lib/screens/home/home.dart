import 'package:flutter/material.dart';
import 'package:nna44_select_list_vocation_and_submit/models/character.dart';
import 'package:nna44_select_list_vocation_and_submit/screens/home/character_card.dart';
import 'package:nna44_select_list_vocation_and_submit/shared/styled_button.dart';
import 'package:nna44_select_list_vocation_and_submit/shared/styled_text.dart';

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
              onPressed: () {
                // navigate to the create screen
              },
              child: const StyledHeading('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
