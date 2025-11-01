import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/models/character.dart' show Character;
import 'package:nna57_routes_and_screens/models/skill.dart' show Skill, allSkills;
import 'package:nna57_routes_and_screens/shared/styled_text.dart' show StyledHeading, StyledText;
import 'package:nna57_routes_and_screens/theme.dart' show AppColors;

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  // declare availableSkills as "late" bc availableSkills initialized
  //   in :fn:initState() instead of ctor.
  late List<Skill> availableSkills;

  @override
  void initState() {
    // compute availableSkills by
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withAlpha(127), // 255 * 0.5 =127
        child: Column(
          children: [
            const StyledHeading('Choose an active skill'),
            const StyledText('Skills are unique to your vocation.'),
            const SizedBox(height: 20),
            // row displays skills
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // use map-fn to create a container per skill in :List<Skill>:availableSkills
              children: availableSkills.map((skill) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(2),
                  child: Image.asset('assets/img/skills/${skill.image}', width: 70),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
