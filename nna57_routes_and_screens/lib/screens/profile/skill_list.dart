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
  late Skill selectedSkill;

  @override
  void initState() {
    // compute availableSkills by
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    // apply reasonable default to :data-member:selectedSkill
    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills[0];
    }
    if (widget.character.skills.isNotEmpty) {
      selectedSkill = widget.character.skills.first;
    }
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
            // fmt
            const StyledHeading('Choose an active skill'),
            const StyledText('Skills are unique to your vocation.'),
            const SizedBox(height: 20),
            // fmt
            // row displays skills
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // use map-fn to create a container per skill in :List<Skill>:availableSkills
              children: availableSkills.map((skill) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(2),
                  color: skill == selectedSkill ? Colors.yellow : Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.character.updateSkill(skill);
                        selectedSkill = skill;
                      });
                    },
                    child: Image.asset('assets/img/skills/${skill.image}', width: 70),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // display name of selectedSkill
            StyledText(selectedSkill.name),
          ],
        ),
      ),
    );
  }
}
