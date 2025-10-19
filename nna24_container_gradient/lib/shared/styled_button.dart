import 'package:flutter/material.dart';
import 'package:nna24_container_gradient/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.onPressed, required this.child});

  final Function() onPressed;
  final Widget child; // e.g. StyledHeading('Btn-Text')

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //      [start color, end color of gradient]
            colors: [AppColors.primaryColor, AppColors.primaryAccent],
            begin: Alignment.topCenter, // start location of gradient
            end: Alignment.bottomCenter, //  end location of gradient
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: child,
      ),
    );
  }
}
