import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_type.dart';

class StorageService {
  static const String _key = 'meal_entries';

  static Future<void> saveEntries(
      Map<DateTime, List<MealType>> entries) async {
    final prefs = await SharedPreferences.getInstance();

    final data = entries.map(
          (date, meals) => MapEntry(
        date.toIso8601String(),
        meals.map((meal) => meal.name).toList(),
      ),
    );

    await prefs.setString(_key, jsonEncode(data));
  }

  static Future<Map<DateTime, List<MealType>>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_key);

    if (json == null) {
      return {};
    }

    final Map<String, dynamic> data = jsonDecode(json);

    final result = <DateTime, List<MealType>>{};

    data.forEach((date, meals) {
      // Compatibilità con il vecchio formato
      if (meals is String) {
        result[DateTime.parse(date)] = [
          MealType.values.firstWhere(
                (e) => e.name == meals,
          )
        ];
      } else {
        result[DateTime.parse(date)] =
            (meals as List)
                .map(
                  (meal) => MealType.values.firstWhere(
                    (e) => e.name == meal,
              ),
            )
                .toList();
      }
    });

    return result;
  }
}