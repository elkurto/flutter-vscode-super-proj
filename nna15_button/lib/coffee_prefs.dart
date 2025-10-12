import 'package:flutter/material.dart';

class CoffeePrefs extends StatelessWidget {
  const CoffeePrefs({super.key});
  void increaseStrength() {
    print("increase Str +1");
  }

  void increaseSugarCube() {
    print("increase SugarCube +1");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/img/coffee_bean.png',
              width: 25,
              colorBlendMode: BlendMode.multiply,
              color: Colors.brown[100],
            ),
            const Text('Strength: '),
            const Text('3'),

            const Expanded(child: SizedBox(width: 100)),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: increaseStrength,
              child: const Text('+'),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/img/sugar_cube.png',
              width: 25,
              colorBlendMode: BlendMode.multiply,
              color: Colors.brown[100],
            ),
            const Text('Sugars: '),
            const Text('3'),
            const Expanded(child: SizedBox(width: 100)),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.brown),
              onPressed: increaseSugarCube,
              child: Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}
