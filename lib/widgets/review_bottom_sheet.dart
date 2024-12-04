import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({super.key});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  List<String> reviews = [];
  Future<void> _loadReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      reviews = prefs.getStringList('reviews') ?? [];
    });
  }

  Future<void> _saveReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('reviews', reviews);
    setState(() {});
  }

  Future<void> _deleteReview(int index) async {
    reviews.removeAt(index);

    await _saveReviews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use min size for bottom sheet
        children: [
          Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${index + 1}. ${reviews[index]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _deleteReview(index); // Delete review
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: reviewController,
            decoration: const InputDecoration(
              labelText: 'Enter your review',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () async {
              if (reviewController.text.isNotEmpty) {
                reviews.add(reviewController.text); // Add new review
                await _saveReviews();
                reviewController.clear(); // Clear the input field

                // Navigator.pop(context); // Close the bottom sheet
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
