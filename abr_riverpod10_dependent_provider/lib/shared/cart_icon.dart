import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/screens/cart/cart_screen.dart';
import 'package:riverpod_files/providers/cart_provider.dart';

// A.11.1 convert Stateless widge to a ConsumerWidget
class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // add :param:ref
    // A.11.2 compute :int: numberOfItemsInCart from provider state
    final numberOfItemsInCart = ref.watch(cartNotifierProvider).length;

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CartScreen();
            }));
          },
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
            ),
            // A.11.3 // use the value computed from Provider state.
            child: Text(numberOfItemsInCart.toString(),
                style: const TextStyle(color: Colors.white) // blah
                ), // end
          ),
        ),
      ],
    );
  }
}
