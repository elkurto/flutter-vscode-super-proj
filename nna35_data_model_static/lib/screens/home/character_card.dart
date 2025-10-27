import 'package:flutter/material.dart';
import 'package:nna35_data_model_static/models/character.dart';
import 'package:nna35_data_model_static/shared/styled_text.dart';
import 'package:nna35_data_model_static/theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor, // just style Card, bc CardTheme is deprecated
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Image.asset('assets/img/vocations/${character.vocation.image}', width: 80),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StyledHeading(character.name), StyledText(character.vocation.title)],
            ),

            const Expanded(child: SizedBox()),

            IconButton(
              onPressed: () {
                // navigate to character profile screen
              },
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
