import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../storage/local_storage.dart';

class ReviewProvider extends ChangeNotifier {
  final LocalStorage storage;

  List<String> _reviews = [];

  ReviewProvider({required this.storage});

  List<String> get reviews => _reviews;

  Future<void> loadReviews() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // _reviews = prefs.getStringList('reviews') ?? [];

    _reviews = await storage.getStringList('reviews') ?? [];
    notifyListeners();
  }

  Future<void> saveReviews() async {
    await storage.setStringList('reviews', _reviews);
    notifyListeners();
  }

  Future<void> addReview(String review) async {
    await storage.addString('reviews', review);
    _reviews = await storage.getStringList('reviews') ??
        []; // Update the local `_reviews` list
    notifyListeners();
  }

  // void deleteReview(int index) async {
  //   _reviews.removeAt(index);
  //   await saveReviews(); // Save after deleting
  //   // notifyListeners();
  // }

  Future<void> deleteReview(String review) async {
    await storage.deleteString('reviews', review);
    _reviews = await storage.getStringList('reviews') ?? [];
    notifyListeners();
  }
}
