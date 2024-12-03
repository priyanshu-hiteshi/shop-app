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
    String descriptionText =
        widget.product.description.length < 60 && !isExpanded
            ? widget.product.description.substring(0, 60) + "... "
            : widget.product.description;

    return ListTile(
      leading: FadeInImage.assetNetwork(
            placeholder: 'Loading...',
            image: widget.product.thumbnail,
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
                  isExpanded = true;
                });
              },
              child: Text(
                "Read more",
                style: TextStyle(
                    color: Colors.blue), // Optional styling for the link
              ),
            ),
        ],
      ),
      trailing: Text(
          "\$${widget.product.price.toStringAsFixed(2)}" , style: TextStyle(
            color: Colors.green 
          ),), // Format price to two decimal places
    );
  }
}