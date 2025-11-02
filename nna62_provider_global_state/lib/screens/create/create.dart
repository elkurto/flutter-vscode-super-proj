import 'package:flutter/material.dart';
import 'package:nna62_provider_global_state/services/character_store.dart' show CharacterStore;
import 'package:nna62_provider_global_state/shared/styled_button.dart';
import 'package:nna62_provider_global_state/shared/styled_text.dart';
import 'package:nna62_provider_global_state/theme.dart';
import 'package:nna62_provider_global_state/models/character.dart';
import 'package:nna62_provider_global_state/models/vocation.dart';
import 'package:nna62_provider_global_state/screens/home/home.dart';
import 'package:nna62_provider_global_state/screens/create/vocation_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // Either use (text fields and onChange) or (TextEditingControllers)
  // Here we use TextEditingController
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  // handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  @override
  void dispose() {
    // explicitly invoke TextEditingController::dispose()
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // a dummy submit handler --
  // the goal of submitHandlers; update the data-model
  void handleSubmit() {
    // validations and conditionally show dialog (if invalid)
    if (_nameController.text.trim().isEmpty) {
      // show error dialog
      // :fn: showDialog is imported via material.dart
      //  (see https://api.flutter.dev/flutter/material/showDialog.html)
      //  (see https://m3.material.io/components/dialogs/overview )
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: AppColors.secondaryAccent,
            surfaceTintColor: AppColors.secondaryAccent,
            title: const StyledHeading('Missing Character Name'),
            content: const StyledText('Every good RPG character needs a great name...'),
            actions: [
              StyledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const StyledHeading('Close'),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );

      return;
    }

    // validations and conditionally show dialog (if invalid)
    if (_sloganController.text.trim().isEmpty) {
      // show error dialog
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: AppColors.secondaryAccent,
            surfaceTintColor: AppColors.secondaryAccent,
            title: const StyledHeading('Missing Character Slogan'),
            content: const StyledText('Remember to add a catchy saying...'),
            actions: [
              StyledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const StyledHeading('Close'),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );

      return;
    }
    //print(_nameController.text);
    //print(_sloganController.text);

    //// replaced block with usage of Provider.of<CharacterStore>...
    // characters.add(
    //   Character(
    //     name: _nameController.text.trim(),
    //     slogan: _sloganController.text.trim(),
    //     vocation: selectedVocation,
    //     id: uuid.v4(),
    //   ),
    // );
    //// lesson-62
    //   a. invoke fn that fetches CharacterStore from context
    Provider.of<CharacterStore>(context, listen: false) //fmt
        .addCharacter(
          // b. create a character instance as a param and
          // c. invoke method CharactStore::addCharacter
          Character(
            name: _nameController.text.trim(),
            slogan: _sloganController.text.trim(),
            vocation: selectedVocation,
            id: uuid.v4(),
          ),
        );

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Home()));
  }

  // a method that handles onTap events (when selecting/de-selecting vocations in list)
  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Character Creation')),
      body: Container(
        // edge padding
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

        child: SingleChildScrollView(
          child: Column(
            children: [
              // welcome message
              Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
              const Center(child: StyledHeading('Welcome, new player.')),
              const Center(child: StyledText('Create a name & slogan for your character.')),
              const SizedBox(height: 30),

              // input widget for name
              TextField(
                controller: _nameController, // assign controller to textField
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character name'),
                ),
                style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
              ),
              // vertical space
              const SizedBox(height: 20),
              // input widget for slogan
              TextField(
                controller: _sloganController, // assign controller to textField
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character slogan'),
                ),
                style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 30),

              // select a vocation title
              Center(child: Icon(Icons.code, color: AppColors.primaryColor)),
              const Center(child: StyledHeading("Choose a Vocation")),
              const Center(child: StyledText("This determines your available skills.")),
              const SizedBox(height: 30),
              //
              // selectable list of vocation cards
              VocationCard(
                vocation: Vocation.junkie,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.junkie,
              ),
              VocationCard(
                vocation: Vocation.ninja,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.ninja,
              ),
              VocationCard(
                vocation: Vocation.wizard,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.wizard,
              ),
              VocationCard(
                vocation: Vocation.raider,
                onTap: updateVocation,
                selected: selectedVocation == Vocation.raider,
              ),
              // submit button w/ :handler:handleSubmit
              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeading('Create Character'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
