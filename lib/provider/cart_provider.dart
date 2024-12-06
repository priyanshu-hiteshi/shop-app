import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _cartItems = {}; // Key: Product ID, Value: CartItem

  Map<int, CartItem> get cartItems => _cartItems;

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((_, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      // Increment quantity if already in cart
      _cartItems[product.id]!.quantity++;
    } else {
      // Add new product to cart
      _cartItems[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int productId) {
    if (_cartItems.containsKey(productId) &&
        _cartItems[productId]!.quantity > 1) {
      _cartItems[productId]!.quantity--;
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
