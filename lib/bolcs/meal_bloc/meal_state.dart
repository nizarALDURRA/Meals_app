part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}
class MealLoaded extends MealState {}
