import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 2. import googe_fonts

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    // 3. use GoogleFonts factory methos in :attr:"style"
    return Text(
      text, // --
      style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.titleMedium),
    );
  }
}
