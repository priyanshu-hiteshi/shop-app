import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_card.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';
import 'product_detail.dart';
import 'cart.dart';
import '../provider/cart_provider.dart'; // Import CartProvider

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.black,
        actions: [
          // Cart Icon with Item Count
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart, size: 28),
                if (cartProvider.cartItems
                    .isNotEmpty) // Only show if there are items in the cart
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartProvider.cartItems.length}', // Display cart item count
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              // Navigate to Cart screen when pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Product Detail screen when product is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(product: product),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                ),
              );
            },
            physics: const BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}
