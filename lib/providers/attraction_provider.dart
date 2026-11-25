import 'package:flutter/material.dart';

import '../data/models/attraction_model.dart';
import '../data/repositories/attraction_repository.dart';

class AttractionProvider extends ChangeNotifier {

  final AttractionRepository repository = AttractionRepository();

  List<Attraction> attractions = [];

  bool isLoading = false;

  String? error;

  Future<void> fetchAttractions() async {

    try {

      isLoading = true;

      error = null;

      notifyListeners();

      attractions = await repository.fetchAttractions();

    } catch (e) {

      error = e.toString();

    } finally {

      isLoading = false;

      notifyListeners();

    }
  }

  final List<Attraction> favorites = [];

  bool isFavorite(Attraction a) {
    return favorites.any((f) => f.title == a.title);
  }

  void toggleFavorite(Attraction a) {
    if (isFavorite(a)) {
      favorites.removeWhere((f) => f.title == a.title);
    } else {
      favorites.add(a);
    }
    notifyListeners();
  }
}
