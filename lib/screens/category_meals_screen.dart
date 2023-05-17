import 'package:flutter/material.dart';
import 'package:meal1_app/bolcs/meal_bloc/meal_cubit.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'add_new_meal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = 'category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryId;
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData=false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routArgs =
      ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryId = routArgs['id']as String;
      categoryTitle = routArgs['title'] as String;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData=true;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
  builder: (context, state) {
    MealCubit cubit = MealCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              image: displayedMeals[index].image,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.playlist_add),
        backgroundColor: Colors.amber,
        key: const Key("Add Meal"),
        label: const Text("Add Meal"),
        onPressed: () {
          Navigator.pushNamed(context, AddMeal.routName, arguments: {'id': categoryId,'title':categoryTitle});
        },
      ),
    );
  },
);
  }
}
