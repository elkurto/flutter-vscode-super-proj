import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';

/// see :branch:lesson-5 for updates A.7.x
/// see :branch:lesson-7 for updated A.8.x
// A.7.1 extend ConsumerStatefulWidget instead of StatefulWidget
//class CartScreen extends StatefulWidget { // old code
class CartScreen extends ConsumerStatefulWidget {
  // new code^^^
  const CartScreen({super.key});

  // A.7.3 create :ConsumerState<CartScreen>: instead of "State<CartScreen>"
  @override
  //State<CartScreen> createState() => _CartScreenState(); //old code
  ConsumerState<CartScreen> createState() => _CartScreenState(); //new code
}

// A.7.2 extend ConsumerState<CartScreen> instead of State<CartScreen>
// class _CartScreenState extends State<CartScreen> { // old code
class _CartScreenState extends ConsumerState<CartScreen> {
  // new code^^^
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
    // A.7.4 watch the data from reducedProductsProvider (see products_provider.dart)
    // Note: ref exposed as inherited field of "ConsumerState<CartScreen>"
    // Note: this is a readonly provider
    //final cartProducts = ref.watch(reducedProductsProvider); // replaced by A.8.3 cartNotifierProvider
    // A.8.3 use cartNotifierProvider (for read and write access to data)
    final cartProducts =
        ref.watch(cartNotifierProvider); // replaces A.7.4 above.
    // A.10.2. access the :Provider<int>:cartTotalProvider
    final cartTotal = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
        // actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              // A.7.5. use the watched_data from provider to display a item card.
              children: cartProducts.map((product) {
                return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Image.asset(product.image, width: 60, height: 60),
                        const SizedBox(width: 10),
                        Text('${product.title}...'),
                        const Expanded(child: SizedBox()),
                        Text('\$${product.price}'),
                      ],
                    ) // end-row
                    ); // end-container
              }).toList(),
            ),
            // A.10.3. display the provided :int:cartTotal
            Text('Total price = $cartTotal'), // output totals here
          ],
        ),
      ),
    );
  }
}
