import 'package:flutter/material.dart';
import 'package:nna26_card_widget/theme.dart' show AppColors;

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final String character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Row(
          children: [
            Text(character),
            // :widget:Expanded pushes icon to far right (layout/right-justify)
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
