import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/models/character.dart';
import 'package:nna57_routes_and_screens/screens/profile/skill_list.dart' show SkillList;
import 'package:nna57_routes_and_screens/screens/profile/stats_table.dart' show StatsTable;
import 'package:nna57_routes_and_screens/shared/styled_button.dart' show StyledButton;
import 'package:nna57_routes_and_screens/shared/styled_text.dart';
import 'package:nna57_routes_and_screens/theme.dart' show AppColors;

class Profile extends StatelessWidget {
  const Profile({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // character name in title
      appBar: AppBar(title: StyledTitle(character.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // basic info - image, vocation, description
            // lesson-51 (passing data into routes)
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.secondaryColor.withAlpha(76), // 255*.30 =76
              child: Row(
                children: [
                  Image.asset(
                    'assets/img/vocations/${character.vocation.image}',
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(width: 20),
                  // must use the :widget:"Expanded" to prevent :error:overflow
                  //   and to force text-wrapping.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledHeading(character.vocation.title),
                        StyledText(character.vocation.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // weapon and ability and slogan
            /// vertical space
            const SizedBox(height: 20),

            /// decoration (icon)
            Center(child: Icon(Icons.code, color: AppColors.primaryColor)),

            /// content (weapon,ability,slogan)
            Padding(
              // fmt
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withAlpha(127), // 255*0.5 =127
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // character.slogan
                    const StyledHeading('Slogan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    // character.vocation.weapon
                    const StyledHeading('Weapon of Choice'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    // character.vocation.ability
                    const StyledHeading('Unique Ability'),
                    StyledText(character.vocation.ability),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // stats & skills
            // (see :stateful_widget:StatsTable)
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  // fmt
                  StatsTable(character), // fmt
                  SkillList(character), // fmt
                ], // end Column.children
              ),
            ),

            // save button that opens a snackbar/toast message
            StyledButton(
              //fmt
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  //fmt
                  SnackBar(
                    //fmt
                    content: const StyledHeading("Character Saved"),
                    showCloseIcon: true,
                    backgroundColor: AppColors.secondaryColor,
                    duration: Duration(seconds: 2),
                  ),
                );
              }, //fmt
              child: StyledHeading("save character"),
            ),
          ], //end-children in Column
        ),
      ),
    );
  }
}
