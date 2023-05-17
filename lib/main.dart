import 'package:flutter/material.dart';
import 'package:meal1_app/bolcs/category_bloc/category_cubit.dart';
import 'package:meal1_app/bolcs/meal_bloc/meal_cubit.dart';
import 'package:meal1_app/screens/add_new_meal.dart';
import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> favoriteMeals = [];
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => CategoryCubit(),
),
    BlocProvider(
      create: (context) => MealCubit(),
    ),
  ],
  child: BlocBuilder<MealCubit, MealState>(
  builder: (context, state) {
    MealCubit cubit = MealCubit.get(context);
    List<Meal> _availableMeals = cubit.meals;

    void _selfFilters(Map<String, bool> filterData) {
      setState(() {
        _filters = filterData;

        _availableMeals = cubit.meals.where((meal) {
          if (_filters['gluten']! && meal.isGlutenFree) return false;
          if (_filters['lactose']! && meal.isLactoseFree) return false;
          if (_filters['vegan']! && meal.isVegan) return false;
          if (_filters['vegetarian']! && meal.isVegetarian) return false;
          return true;
        }).toList();
      });
    }

    void _toggleFavorite(String mealId) {
      final existingIndex =
      favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex >= 0) {
        setState(() {
          favoriteMeals.removeAt(existingIndex);
        });
      } else {
        setState(() {
          favoriteMeals.add(
            cubit.meals.firstWhere((meal) => meal.id == mealId),
          );
        });
      }
    }

    bool _isMealFavorite(String id) {
      return favoriteMeals.any((meal) => meal.id == id);
    }

    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        hintColor: Colors.black,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      home: TabsScreen(favoriteMeals),
      initialRoute: 'homee',
      routes: {
        'homee': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite,cubit),
        FiltersScreen.routName: (ctx) => FiltersScreen(_filters, _selfFilters),
        AddMeal.routName: (ctx) => AddMeal(),
      },
      onGenerateRoute: (setting) {
        print(setting.arguments);
        // return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  },
),
);
  }
}
