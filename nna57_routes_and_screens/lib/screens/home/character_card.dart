import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/models/character.dart';
import 'package:nna57_routes_and_screens/screens/profile/profile.dart' show Profile;
import 'package:nna57_routes_and_screens/shared/styled_text.dart';
import 'package:nna57_routes_and_screens/theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor, // just style Card here ; bc CardTheme is deprecated
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // 1, image icon
            Image.asset('assets/img/vocations/${character.vocation.image}', width: 80),
            // size box for white-space
            const SizedBox(width: 20),
            // 2, mini-column that contains name, title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StyledHeading(character.name), StyledText(character.vocation.title)],
            ),
            // 3. Expanded-widget to push icon button to far right
            const Expanded(child: SizedBox()),

            // 4. icon button
            IconButton(
              onPressed: () {
                // navigate to character profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => Profile(character: character)),
                );
              },
              icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
