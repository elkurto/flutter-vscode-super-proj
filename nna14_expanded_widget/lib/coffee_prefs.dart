import 'package:flutter/material.dart';

class CoffeePrefs extends StatelessWidget {
  const CoffeePrefs({super.key});

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
            const Text('+'),
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
            const Text('+'),
          ],
        ),
      ],
    );
  }
}
