import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/review_provider.dart'; // Import your ReviewProvider

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({super.key});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController reviewController = TextEditingController();

  String? errorMessage; // To store validation message

  @override
  void initState() {
    super.initState();
    // Load reviews when the bottom sheet is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReviewProvider>(context, listen: false).loadReviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use min size for bottom sheet
        children: [
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10), // Space between title and review list
          Expanded(
            child: ListView.builder(
              itemCount: reviewProvider.reviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${index + 1}. ${reviewProvider.reviews[index]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // Delete review using the updated provider method
                          await reviewProvider
                              .deleteReview(reviewProvider.reviews[index]);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
              height: 10), // Space between review list and input field
          TextField(
            controller: reviewController,
            decoration: InputDecoration(
              labelText: 'Enter your review',
              border: const OutlineInputBorder(),
              errorText: errorMessage, // Use errorText for inline validation
            ),
          ),
          const SizedBox(height: 18), // Space between text field and button
          ElevatedButton(
            onPressed: () async {
              if (reviewController.text.isEmpty) {
                setState(() {
                  errorMessage = 'Review cannot be empty'; // Show error message
                });
              } else {
                final newReview = reviewController.text;

                // Perform the async operation outside setState
                await reviewProvider.addReview(newReview);

                // Clear the input field and reset the error message in setState
                setState(() {
                  errorMessage = null; // Clear error message
                  reviewController.clear(); // Clear the input field
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 116, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Submit Review',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
