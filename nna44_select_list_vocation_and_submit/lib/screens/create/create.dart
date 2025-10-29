import 'package:flutter/material.dart';
import 'package:nna44_select_list_vocation_and_submit/shared/styled_button.dart';
import 'package:nna44_select_list_vocation_and_submit/shared/styled_text.dart';
import 'package:nna44_select_list_vocation_and_submit/theme.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // validations
    if (_nameController.text.trim().isEmpty) {
      print('name must not be empty');
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      print('slogan must not be empty');
      return;
    }
    print(_nameController.text);
    print(_sloganController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StyledTitle('Character Creation')),
      body: Container(
        // edge padding
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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

            // submit button w/ onSubmit
            Center(
              child: StyledButton(
                onPressed: handleSubmit,
                child: const StyledHeading('Create Character'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
