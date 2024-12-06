import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    context.findRenderObject();
    String descriptionText =
        widget.product.description.length < 60 && !isExpanded
            ? widget.product.description.substring(0, 60) + "... "
            : widget.product.description;

    return ListTile(
      leading: Image.network(
        widget.product.thumbnail,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return child;
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
      ),
      title: Text(widget.product.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(descriptionText),
          if (widget.product.description.length > 60 && !isExpanded)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? "Read less" : "Read more",
                style: TextStyle(
                    color: Colors.blue), // Optional styling for the link
              ),
            ),
        ],
      ),
      trailing: Text(
        "\$${widget.product.price.toStringAsFixed(2)}",
        style: TextStyle(color: Colors.green),
      ), // Format price to two decimal places
    );
  }
}
