import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/category.dart';
import '../models/meal.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;
  static bool isMealsEmpty = true;

  DatabaseHelper._instance();

  DatabaseHelper() {
    database;
  }

  List<String> table = ["Categories", "Meals"];

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _createDataBase();
    return _database;
  }

  _createDataBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    io.Directory directory = await getApplicationDocumentsDirectory();
    final database = openDatabase(
      join(directory.path, 'meal_data.db'),
      onCreate: _onCreate,
      version: 1,
    );
    return database;
  }

  _onCreate(Database db, int version) async {
    db.execute(
        'CREATE TABLE "${table[1]}" ("id" INTEGER NOT NULL PRIMARY KEY UNIQUE, "title" TEXT NOT NULL UNIQUE, "image" TEXT NOT NULL,'
            '"categories" TEXT NOT NULL , "ingredients" TEXT NOT NULL,"steps" TEXT NOT NULL , "duration" TEXT NOT NULL,'
            '"complexity" TEXT NOT NULL,"affordability" TEXT NOT NULL ,"isGlutenFree" Text NOT NULL ,'
            '"isLactoseFree" TEXT NOT NULL ,"isVegan" TEXT NOT NULL ,"isVegetarian" TEXT NOT NULL );');
    db.execute(
        'CREATE TABLE "${table[0]}" ("id" INTEGER NOT NULL PRIMARY KEY UNIQUE, "title" TEXT NOT NULL UNIQUE, "image" TEXT NOT NULL);');
    return db;
  }

  Future<List<Map<String, dynamic>>> _getCategoryMapList() async {
    Database? db = await database;
    final List<Map<String, dynamic>> result = await db!.query(table[0]);
    return result;
  }

  Future<List<Category>> getCategoriesList() async {
    final List<Map<String, dynamic>> categoryMapList =
    await _getCategoryMapList();
    final List<Category> categoryList = [];

    for (var categoryMap in categoryMapList) {
      categoryList.add(Category.fromMap(categoryMap));
    }
    return categoryList;
  }

  Future<void> insertCategory(Category category) async {
    category.id=Category.countCategories.toString();
    final db = await database;
    await db?.insert(
      table[0],
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Category added');
    Category.countCategories++;
  }


//8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

  Future<List<Map<String, dynamic>>> _getMealsMapList() async {
    Database? db = await database;
    final List<Map<String, dynamic>> result = await db!.query(table[1]);
    return result;
  }

  Future<List<Meal>> getMealsList() async {
    final List<Map<String, dynamic>> mealsMapList = await _getMealsMapList();
    final List<Meal> mealsList = [];

    for (var mealMap in mealsMapList) {
      print(Meal.fromMap(mealMap));
      mealsList.add(Meal.fromMap(mealMap));
    }
    return mealsList;
  }

  Future<void> insertMeal(Meal meal) async {
    final db = await database;
    meal.id=Meal.countMeals.toString();
    await db!.insert(
      table[1],
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Meal.countMeals++;
  }
  //
  // Future<void> updateMeal(Meal meal) async {
  //   final db = await database;
  //
  //   await db?.update(
  //     table[1],
  //     meal.toMap(),
  //     where: 'id = ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [meal.id],
  //   );
  // }
  //
  // Future<void> deleteMeal(int id) async {
  //   final db = await database;
  //   await db?.delete(
  //     table[1],
  //     where: 'id = ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }

// Example to use it
// var fido = const Dog(
//   id: 0,
//   name: 'Fido',
//   age: 35,
// );
//
// await insertDog(fido);
}
