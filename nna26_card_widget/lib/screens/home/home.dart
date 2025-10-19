import 'package:flutter/material.dart';
import 'package:nna26_card_widget/shared/styled_text.dart';
import 'package:nna26_card_widget/shared/styled_button.dart';
import 'package:nna26_card_widget/screens/home/character_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List characters = ['R.Moore', 'D.Lydic', 'J.Oliver', 'J.Carlin', 'J.Klepper', 'K.Knowles'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Your Characters - :font:kanit'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              // Need `Expanded` to help Flutter's layout manager,
              // because ListView has unconstrained height.
              // So :widget:"Expanded" must wrap :child:"ListView"
              // because "ListView" is automatically scrollable.
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return CharacterCard(characters[index]);
                },
              ),
            ),
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
