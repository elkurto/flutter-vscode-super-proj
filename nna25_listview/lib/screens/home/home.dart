import 'package:flutter/material.dart';
import 'package:nna25_listview/shared/styled_text.dart';
import 'package:nna25_listview/shared/styled_button.dart';

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
                  return Container(
                    color: Colors.grey[800],
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: StyledText(characters[index]),
                  );
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
