import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meal1_app/bolcs/meal_bloc/meal_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal1_app/file_operations.dart';
class MealDetailScreen extends StatelessWidget {
  static const routName = 'meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  MealCubit cubit;

  MealDetailScreen(this.toggleFavorite,this.isFavorite,this.cubit);

  Widget buildScreenTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = cubit.meals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: selectedMeal.image.contains('assets/images/')?Image.asset(
                selectedMeal.image,
                fit: BoxFit.cover,
              ):Image.memory(
                getImageBytes(selectedMeal.image),
                fit: BoxFit.cover,
              ),
            ),
            buildScreenTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Colors.yellow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
              ),
            ),
            buildScreenTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed:()=> toggleFavorite(mealId),
      ),
    );
  }
}
