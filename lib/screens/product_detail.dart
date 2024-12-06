import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_ecom/screens/cart.dart';
import 'package:my_ecom/widgets/review_bottom_sheet.dart';
import 'package:my_ecom/provider/cart_provider.dart'; // Import CartProvider
import '../models/product_model.dart'; // Import the product model

class Detail extends StatefulWidget {
  final Product product; // Accept product as a parameter

  const Detail({Key? key, required this.product}) : super(key: key);

  @override
  State<Detail> createState() => _CartState();
}

class _CartState extends State<Detail> {
  // Function to show the bottom sheet
  void _showReviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ReviewBottomSheet(
          reviews: widget.product.reviews ?? [], // Pass reviews here
        );
      },
    );
  }

  // Calculate the average rating based on reviews
  double calculateAverageRating() {
    if (widget.product.reviews == null || widget.product.reviews!.isEmpty) {
      return 0.0;
    }
    double totalRating = 0.0;

    for (var review in widget.product.reviews!) {
      totalRating +=
          review.rating ?? 0.0; // Access the 'rating' property directly
    }

    return totalRating / widget.product.reviews!.length;
  }

  // Get the number of full stars based on the average rating
  int getFullStars(double averageRating) {
    return averageRating.floor();
  }

  // Get the number of half stars based on the decimal part of the average rating
  bool hasHalfStar(double averageRating) {
    return averageRating - averageRating.floor() >= 0.5;
  }

  // Get the number of empty stars based on the full and half stars
  int getEmptyStars(double averageRating) {
    return 5 -
        getFullStars(averageRating) -
        (hasHalfStar(averageRating) ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the average rating for the product
    double averageRating = calculateAverageRating();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 380,
          margin: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display product image
                Container(
                  padding: const EdgeInsets.all(12.0),
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.product.images![0]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.title, // Display product title
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      widget.product.description, // Display product description
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 67, 67, 67)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${widget.product.price.toStringAsFixed(2)}', // Display product price
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 8.0), // Add top margin here
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Space between elements
                      children: [
                        Row(
                          children: [
                            // Display stars based on average rating
                            for (int i = 0;
                                i < getFullStars(averageRating);
                                i++)
                              const Icon(Icons.star,
                                  size: 18.0, color: Colors.amber),
                            if (hasHalfStar(averageRating))
                              const Icon(Icons.star_half,
                                  size: 18.0, color: Colors.amber),
                            for (int i = 0;
                                i < getEmptyStars(averageRating);
                                i++)
                              const Icon(Icons.star_border,
                                  size: 18.0, color: Colors.amber),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add product to cart
                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);
                            cartProvider.addToCart(widget.product);

                            // Optionally, show a snackbar or navigate to the cart
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${widget.product.title} added to cart'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 233, 210, 2), // Button color
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              )),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showReviewBottomSheet,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add_comment, color: Colors.white),
          ),
          const Text(
            'Reviews',
            style: TextStyle(
              color: Color.fromARGB(255, 165, 164, 164),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
