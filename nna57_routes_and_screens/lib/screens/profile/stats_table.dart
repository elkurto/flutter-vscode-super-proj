import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/models/character.dart';
import 'package:nna57_routes_and_screens/shared/styled_text.dart';
import 'package:nna57_routes_and_screens/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});
  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // available points
          Container(
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.star, color: widget.character.points > 0 ? Colors.yellow : Colors.grey),
                const SizedBox(width: 20),
                const StyledText('Stat points available:'),
                const Expanded(child: SizedBox()),
                StyledHeading(widget.character.points.toString()),
              ],
            ),
          ),

          // stats table
          Table(
            // use the map fn to create a List<TableRow> (one TableRow per stat)
            // note: stat['title'] is in {health,attack,defense,skill}
            children: widget.character.statsAsFormattedList.map((stat) {
              return TableRow(
                decoration: BoxDecoration(
                  // set the background color of the table.
                  color: AppColors.secondaryColor.withAlpha(127),
                ), // 255*0.5 =127
                children: [
                  // can be a list of any widget, this example uses TableCells explicitly.
                  // TableCell for stat['title']
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: StyledHeading(stat['title']!),
                    ),
                  ),

                  // TableCell for stat['value']
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: StyledHeading(stat['value']!),
                    ),
                  ),

                  // TableCell for :icon:"increment Stat value"
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon: Icon(Icons.arrow_upward, color: AppColors.textColor),
                      onPressed: () {
                        setState(() {
                          // use setState to notify widget to redraw.
                          widget.character.increaseStat(stat['title']!);
                        });
                      },
                    ),
                  ),

                  // TableCell for :icon:"decrement stat value"
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward, color: AppColors.textColor),
                      onPressed: () {
                        setState(() {
                          // use setState to notify widget to redraw.
                          widget.character.decreaseStat(stat['title']!);
                        });
                      },
                    ),
                  ),
                ],
              );
            }).toList(), // convert from Iterator<TableRow> to List<TableRow>
          ),
        ],
      ),
    );
  }
}
