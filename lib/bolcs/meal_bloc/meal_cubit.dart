import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal1_app/dataBase/data_base.dart';
import 'package:meal1_app/models/meal.dart';
import 'package:flutter/material.dart';
import '../../dummy_data.dart';
import '../../file_operations.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  late List<Meal> meals = [];
  late List<Meal> mealsTemp = [];
  late String pathImages;

  MealCubit() : super(MealInitial()) {
    if (meals.isEmpty) {
      fillMealList();
    }
  }

  Future<void> fillMealList() async {
    List<Meal> temp = await DatabaseHelper.instance.getMealsList();
    meals = DummyData().getDummyMeals() + temp;
    mealsTemp = DummyData().getDummyMeals() + temp;
    emit(MealInitial());
  }

  static MealCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Future<void> addMealToDatabase(
    String mealName,
    String mealImage,
    Affordability affordability,
    String categories,
    Complexity complexity,
    String duration,
    String ingredients,
    bool isGlutenFree,
    bool isLactoseFree,
    bool isVegan,
    bool isVegetarian,
    String steps,
  ) async {
    DatabaseHelper.instance.insertMeal(Meal(
      id: '',
      title: mealName,
      image: await getImagePathFile(mealName,mealImage),
      affordability: affordability,
      categories: [categories],
      complexity: complexity,
      duration: duration,
      ingredients: [ingredients],
      isGlutenFree: isGlutenFree,
      isLactoseFree: isLactoseFree,
      isVegan: isVegan,
      isVegetarian: isVegetarian,
      steps: [steps],
    ));
    meals = mealsTemp + (await DatabaseHelper.instance.getMealsList());
    emit(MealLoaded());
  }
}
