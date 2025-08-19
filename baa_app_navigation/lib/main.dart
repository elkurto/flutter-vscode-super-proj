import 'package:flutter/cupertino.dart';

// source = https://docs.flutter.dev/cookbook/navigation/navigation-basics
// this example uses Navigator.push(...) and Navigator.pop(...)
// [other Navigator methods include](https://docs.flutter.dev/cookbook/navigation/navigation-basics#additional-navigation-methods) :
// pushAndRemoveUntil: Adds a navigation route to the stack and then removes the most recent routes from the stack until a condition is met.
// pushReplacement: Replaces the current route on the top of the stack with a new one.
// replace: Replace a route on the stack with another route.
// replaceRouteBelow: Replace the route below a specific route on the stack.
// popUntil: Removes the most recent routes that were added to the stack of navigation routes until a condition is met.
// removeRoute: Remove a specific route from the stack.
// removeRouteBelow: Remove the route below a specific route on the stack.
// restorablePush: Restore a route that was removed from the stack.

void main() {
  runApp(const CupertinoApp(title: 'Navigation Basics', home: FirstRoute()));
}

// a widget that represents a home screen
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                builder: (context) => const SecondRoute(),
              ),
            );
          },
        ),
      ),
    );
  }
}

// a widget that represents a second screen
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
