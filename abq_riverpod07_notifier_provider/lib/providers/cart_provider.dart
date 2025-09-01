import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/product.dart';

// A.8.1 create a CartNotifier
// Note: the :NotifierProvider:CartNotifier specifies data (as a provider),
// and methods to mutuate data_from_provider.
// Note: Riverpod handles the notifications to consumers (upon data chnage).
class CartNotifier extends Notifier<Set<Product>> {
  // initial state (initial value)
  @override
  Set<Product> build() {
    return const {
      // Note: Typically, a notifier creates empty (ie emtpy set) initial state.
      // This state is non-empty for example purposes only.
      Product(
          id: '4',
          title: 'Red Backpack',
          price: 14,
          image: 'assets/products/backpack.png'),
    };
  } //end build

  // A.9.1 methods to update this.state
  // Note: :Set<Product>:this.state is a data-member inherited from Notifier<Set<Product>>
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  // A.9.1 methods to update this.state
  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

// A.8.2 create a NotifierProvider
final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
  return CartNotifier(); // just return the default CartNotifier instance.
});
