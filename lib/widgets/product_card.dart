import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isExpanded = false; // Tracks whether the description is expanded

  @override
  Widget build(BuildContext context) {
    // Show the first 50 characters if not expanded, else show full description
    String descriptionText = isExpanded
        ? widget.product.description
        : widget.product.description.length > 50
            ? widget.product.description.substring(0, 50) + "..."
            : widget.product.description;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Create space between image and description
          children: [
            Container(
              height: 60,
              width: 60,
              child: Image.network(
                widget.product.images![0],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8), // Space between image and text
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                        height: 8), // Add space between title and description
                    Text(
                      descriptionText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (widget.product.description.length > 50)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded =
                                !isExpanded; // Toggle the expanded state
                          });
                        },
                        child: Text(
                          isExpanded ? "Read less" : "Read more",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ), // Styling for the link
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
