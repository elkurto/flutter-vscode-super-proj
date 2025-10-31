import 'package:flutter/material.dart';
import 'package:nna44_select_list_vocation_and_submit/models/vocation.dart';
import 'package:nna44_select_list_vocation_and_submit/shared/styled_text.dart';
import 'package:nna44_select_list_vocation_and_submit/theme.dart';

class VocationCard extends StatelessWidget {
  // ctor
  const VocationCard({
    super.key,
    required this.vocation,
    required this.onTap,
    required this.selected,
  });

  // instance data
  final Vocation vocation;
  final void Function(Vocation) onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(vocation);
      },
      child: Card(
        color: selected ? AppColors.secondaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // vocation img
              Image.asset(
                'assets/img/vocations/${vocation.image}',
                width: 80,
                // conditional styleing (see lesson-43)
                colorBlendMode: BlendMode.color,
                color: !selected ? Colors.black.withAlpha(204) : Colors.transparent,
              ),
              const SizedBox(width: 10),

              // vocation name & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [StyledHeading(vocation.title), StyledText(vocation.description)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
