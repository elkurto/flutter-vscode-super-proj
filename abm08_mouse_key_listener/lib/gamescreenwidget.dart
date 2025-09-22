import 'package:abm08_mouse_key_listener/gamestate.dart';
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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    gameState.initState();
    _controller.duration = duration;
    _controller.repeat();
    _controller.addListener(_update);
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

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        gameState.inputController.handleKeyEvent(event);
      },
      child: MouseRegion(
        onHover: (pointerHoverEvent) {
          gameState.inputController.handlePointerHoverEvent(pointerHoverEvent);
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: GestureDetector(
            onTapDown: (tapDownDetails) =>
                gameState.inputController.handleTapDownEvent(tapDownDetails),

            child: CustomPaint(
              painter: GamePainter(gameState, _controller),
              child: const SizedBox.expand(),
            ),
          ),
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
