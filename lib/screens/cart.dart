import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty!'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems.values.toList()[index];
                      return ListTile(
                        leading: Image.network(cartItem.product.images![0],
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(cartItem.product.title),
                        subtitle: Text(
                          'Quantity: ${cartItem.quantity}\nSubtotal: \$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => cartProvider
                                  .decrementQuantity(cartItem.product.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cartProvider
                                  .incrementQuantity(cartItem.product.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
