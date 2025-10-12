import 'package:flutter/material.dart';
import 'dart:math' as math;

class CoffeePrefs extends StatefulWidget {
  const CoffeePrefs({super.key});

  @override
  State<CoffeePrefs> createState() => _CoffeePrefsState();
}

class _CoffeePrefsState extends State<CoffeePrefs> {
  int strength = 1;
  int sugarCube = 1;
  final int maxN = 5;
  final int minN = 1;
  void increaseStrength() {
    setState(() {
      strength = math.min(maxN, strength + 1);
    });
  }

  void increaseSugarCube() {
    setState(() {
      sugarCube = math.min(maxN, sugarCube + 1);
    });
  }

  void decreaseStrength() {
    setState(() {
      strength = math.max(minN, strength - 1);
    });
  }

  void decreaseSugarCube() {
    setState(() {
      sugarCube = math.max(minN, sugarCube - 1);
    });
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
            Text("$strength"),

            const Expanded(child: SizedBox(width: 100)),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: increaseStrength,
              child: const Text('+'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: decreaseStrength,
              child: const Text('-'),
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
            Text("$sugarCube"),
            const Expanded(child: SizedBox(width: 100)),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.brown),
              onPressed: increaseSugarCube,
              child: Text('+'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.brown),
              onPressed: decreaseSugarCube,
              child: Text('-'),
            ),
          ],
        ),
      ],
    );
  }
}
