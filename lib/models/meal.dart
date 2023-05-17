import 'dart:convert';

import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}
enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  static int countMeals = 11;
  late String id;
  final List<String> categories;
  final String title;
  final String image;
  final List<String> ingredients;
  final List<String> steps;
  final String duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  Meal(
      {required this.id,
      required this.title,
      required this.image,
      required this.affordability,
      required this.categories,
      required this.complexity,
      required this.duration,
      required this.ingredients,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian,
      required this.steps});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'image': image,
      'affordability':affordability.index.toString(),
      'duration': duration,
      'steps': steps.toString(),
      'categories': categories.toString(),
      'complexity': complexity.index.toString(),
      'ingredients': ingredients.toString(),
      'isVegetarian': isVegetarian.toString(),
      'isGlutenFree': isGlutenFree.toString(),
      'isLactoseFree': isLactoseFree.toString(),
      'isVegan': isVegan.toString(),
    };
  }

  static Meal fromMap(Map<String, dynamic> mealMap) {
    List<String> st = (mealMap['steps'] as String).split('\n').map((e) {
      e=e.replaceAll('[', '');
      e=e.replaceAll(']', '');
      return e;
    }).toList();
    st.removeWhere((element) => element.isEmpty);
    List<String> ca = (mealMap['categories'] as String).split(',').map((e) {
      e=e.replaceAll('[', '');
      e=e.replaceAll(']', '');
      return e;
    }).toList();
    ca.removeWhere((element) => element.isEmpty);
    List<String> ind = (mealMap['ingredients'] as String).split('\n').map((e) {
      e=e.replaceAll('[', '');
      e=e.replaceAll(']', '');
      return e;
    }).toList();
    ind.removeWhere((element) => element.isEmpty);
    return Meal(
      id: mealMap['id'].toString(),
      title: mealMap['title'],
      image: mealMap['image'],
      affordability: Affordability.values[int.fromEnvironment(mealMap['affordability'])],
      duration: mealMap['duration'],
      steps: st,
      categories: ca,
      complexity: Complexity.values[int.fromEnvironment(mealMap['complexity'])],
      ingredients: ind,
      isVegetarian: bool.fromEnvironment(mealMap['isVegetarian']),
      isGlutenFree: bool.fromEnvironment(mealMap['isGlutenFree']),
      isLactoseFree: bool.fromEnvironment(mealMap['isLactoseFree']),
      isVegan: bool.fromEnvironment(mealMap['isVegan']),
    );
  }

  @override
  String toString() {
    return 'Meal{id: $id, title: $title, image: $image, affordability:$affordability, duration:$duration, steps:$steps, '
        'categories:$categories, complexity:$complexity, ingredients:$ingredients, isVegetarian:$isVegetarian, '
        'isGlutenFree:$isGlutenFree, isLactoseFree:$isLactoseFree, isVegan:$isVegan}';
  }
}
