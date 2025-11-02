import 'package:flutter/material.dart';
//import 'package:nna62_provider_global_state/models/character.dart'; no longer neede - replaced by CharacterStore
import 'package:nna62_provider_global_state/screens/home/character_card.dart';
import 'package:nna62_provider_global_state/shared/styled_button.dart';
import 'package:nna62_provider_global_state/shared/styled_text.dart';
import 'package:nna62_provider_global_state/screens/create/create.dart';
import 'package:nna62_provider_global_state/services/character_store.dart' show CharacterStore;
import 'package:provider/provider.dart' show Consumer;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Your Characters'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // list of characters
            Expanded(
              // lesson-61
              // idiom for using a Consumer<ChartacterStore>
              child: Consumer<CharacterStore>(
                // context:BuilderContext
                // value:CharacterStore // the provided CharaterStore instance
                // child:Widget ???
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.characters.length,
                    itemBuilder: (_, index) {
                      return CharacterCard(value.characters[index]);
                    },
                  );
                }, //end-anonymous-fn-'builder'
              ), //Consumer<CharacterStore>
            ),

            StyledButton(
              // lesson-47 - push :widget:Create on Navigator's stack
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Create()));
              },
              child: const StyledHeading('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
