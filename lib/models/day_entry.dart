import 'meal_type.dart';

class DayEntry {
  final DateTime date;
  MealType mealType;

  DayEntry({
    required this.date,
    required this.mealType,
  });
}