import 'package:flutter/material.dart';
import '../models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> items = [];

  void add(Food food) {
    items.add(food);
    notifyListeners();
  }

  void remove(Food food) {
    items.remove(food);
    notifyListeners();
  }

  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.price;
    }
    return sum;
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}
