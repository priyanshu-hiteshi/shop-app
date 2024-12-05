import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewProvider extends ChangeNotifier {
  List<String> _reviews = [];

  List<String> get reviews => _reviews;

  Future<void> loadReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _reviews = prefs.getStringList('reviews') ?? [];
    notifyListeners();
  }

  Future<void> saveReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('reviews', _reviews);
    notifyListeners();
  }

  void addReview(String review) {
    _reviews.add(review);
    saveReviews(); // Save after adding
    notifyListeners();
  }

  void deleteReview(int index) {
    _reviews.removeAt(index);
    saveReviews(); // Save after deleting
    notifyListeners();
  }
}
