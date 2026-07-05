import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_type.dart';

class StorageService {
  static const String _key = 'meal_entries';

  static Future<void> saveEntries(
      Map<DateTime, MealType> entries) async {
    final prefs = await SharedPreferences.getInstance();

    final data = entries.map(
          (date, meal) => MapEntry(
        date.toIso8601String(),
        meal.name,
      ),
    );

    await prefs.setString(_key, jsonEncode(data));
  }

  static Future<Map<DateTime, MealType>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_key);

    if (json == null) {
      return {};
    }

    final Map<String, dynamic> data = jsonDecode(json);

    final result = <DateTime, MealType>{};

    data.forEach((date, meal) {
      result[DateTime.parse(date)] = MealType.values.firstWhere(
            (e) => e.name == meal,
      );
    });

    return result;
  }
}