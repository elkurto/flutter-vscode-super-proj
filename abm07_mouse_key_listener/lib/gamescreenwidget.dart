import 'package:abm07_mouse_key_listener/gamestate.dart';
import 'package:flutter/material.dart';

class GameScreenWidget extends StatefulWidget {
  const GameScreenWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameScreenWidgetState();
  }
}

class _GameScreenWidgetState extends State<GameScreenWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, upperBound: 100.0);
  final Duration duration = const Duration(seconds: 20);
  final GameState gameState = GameState.instance;

  @override
  void initState() {
    super.initState();
    gameState.initState();
  }

  void _update() {
    setState(() => gameState.act());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gameState.size ??= MediaQuery.of(context).size;
    if (!gameState.isLoaded()) {
      return const Center(child: Text('loading...'));
    }

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: GestureDetector(
        onTapDown: (details) => gameState.addSpriteAtLocalOffset(details.localPosition),
        child: CustomPaint(
          painter: GamePainter(gameState, _controller),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  final GameState gameState;
  final Animation<double> animation;

  const GamePainter(this.gameState, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    gameState.size = size;
    gameState.draw(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
