

// Cria classe restaurante

import 'package:appdeliverytb/model/dish.dart';

class Restaurant {
  String id;
  String imagePath;
  String name;
  String description;
  double stars;
  int distance;
  List<String> categories;
  List<Dish> dishes;

  // Cria construtor
  Restaurant({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.stars,
    required this.distance,
    required this.categories,
    required this.dishes
  });

  // Cria mapa para converter elementos json para o app consumir
  Map<String,dynamic>toMap(){
  return{
    'id':id,
    'imagePath':imagePath,
    'name':name,
    'description':description,
    'stars':stars,
    'distance':distance,
    'categories':categories,
    // função arrow para transformar os pratos em uma lista
    'dishes':dishes.map((dish)=>dish.toMap()).toList()
  };
  }

  // queremos receber o mapa para criar o restaurante

  factory Restaurant.fromMap(Map<String,dynamic>map){
    return Restaurant(
      id:map['id'],
      imagePath: map['imagePath'],
      name: map['name'],
      description: map['description'],
      stars: map['stars'],
      distance:map['distance'],
      categories:List<String>.from(map['categories']),
      dishes:List<Dish>.from(map['dishes'].map((dish)=>Dish.fromMap(dish))),
    );
    
  }

  // Função para converter para String

  @override 
  String toString(){
    return ''' Restaurant(
    id:$id,
    imagePath: $imagePath,
    name: $name,
    description: $description,
    stars: $stars,
    distance: $distance,
    categories: $categories
    )''';
  }
}