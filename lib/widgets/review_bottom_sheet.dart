import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/product_model.dart'; // Import the Review model

class ReviewBottomSheet extends StatelessWidget {
  final List<Review> reviews; // Accept reviews as a parameter

  const ReviewBottomSheet({Key? key, required this.reviews}) : super(key: key);

  String formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy hh:mm a')
        .format(date); // Format date & time
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 22, 22, 22), // Background color
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.5, // Border width
                        style: BorderStyle
                            .solid, // Border style (solid, dashed, etc.)
                      ), // Border radius
                    ),
                    padding: const EdgeInsets.all(
                        12.0), // Padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display email and formatted date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review.reviewerName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 211, 209, 209),
                              ),
                            ),
                            Text(
                              formatDate(review.date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Display the review comment
                        Text(
                          review.comment,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Display star ratings
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < review.rating
                                  ? Icons.star
                                  : Icons
                                      .star_border, // Filled or outlined star
                              color: Colors.amber, // Star color
                              size: 16, // Star size
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
