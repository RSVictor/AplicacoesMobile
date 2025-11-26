import 'package:flutter/material.dart';
import '../models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> items = [];

  // Adiciona um item ao carrinho
  void add(Food food) {
    items.add(food);
    notifyListeners();
  }

  // Remove um item do carrinho
  void remove(Food food) {
    items.remove(food);
    notifyListeners();
  }

  // Calcula o total de preço dos itens no carrinho
  double get total {
    double sum = 0;
    for (var item in items) {
      sum += item.price;
    }
    return sum;
  }

  // Limpa o carrinho
  void clear() {
    items.clear();
    notifyListeners();
  }

  // Conta o número total de itens no carrinho
  int get itemCount {
    return items.length;
  }
}
