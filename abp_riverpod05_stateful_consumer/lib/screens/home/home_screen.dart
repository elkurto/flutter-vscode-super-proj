import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

// A.3 Extend ConsumerWidget instead of StatelessWidget,
//   so that HomeScreen can access (consumer) of ProviderWidget's state.
// Note:  StatefulWidgets extend ConsumerStatefulWidget
// Note:  StatelessWidgets extend ConsumerWidget
// class HomeScreen extends StatelessWidget { // old code
class HomeScreen extends ConsumerWidget {
  //new-code^^^
  const HomeScreen({super.key});

  @override
  // A.4 add :param:WidgetRef to :method:build(...)
  // Note: :WidgetRef:ref provides access to data
  //        in flutter_riverpod.Provider(s).
  //Widget build(BuildContext context) { // old code
  Widget build(BuildContext context, WidgetRef ref) {
    //new-code^^^
    // A.5. Use ref.watch to access data from provider.
    // Note: :method: ref.watch allow initial read and
    //   later updates of data in :riverpad.Provider:"productsProvider"
    final allProducts = ref.watch(productsProvider); //new

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length, //A.6.1 use data from provider
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blueGrey.withOpacity(0.05),
                child: Column(
                  children: [
                    // A.6.2. use data from provider
                    Image.asset(allProducts[index].image,
                        width: 60, height: 60),
                    Text(allProducts[index].title),
                    Text("\$${allProducts[index].price}")
                  ],
                ));
          },
        ),
      ),
    );
  }
}
