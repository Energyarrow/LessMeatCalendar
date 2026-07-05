import 'package:flutter/material.dart';

import '../models/meal_dialog_result.dart';
import '../models/meal_type.dart';
import '../services/storage_service.dart';
import '../widgets/meat_choice_dialog.dart';

class HomeController {
  static Future<void> onDaySelected({
    required BuildContext context,
    required DateTime selectedDay,
    required DateTime focusedDay,
    required Map<DateTime, List<MealType>> entries,
    required VoidCallback refresh,
    required Function(DateTime) updateFocusedDay,
    required Function(DateTime?) updateSelectedDay,
  }) async {
    updateSelectedDay(selectedDay);
    updateFocusedDay(focusedDay);

    final key = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    final initialMeals = entries[key] ?? [];

    final result = await showMealChoiceDialog(
      context,
      initialMeals,
    );

    if (result == null) {
      refresh();
      return;
    }

    switch (result.action) {
      case MealDialogAction.select:
        if (result.mealTypes != null &&
            result.mealTypes!.isNotEmpty) {
          entries[key] = result.mealTypes!;
        } else {
          entries.remove(key);
        }
        break;

      case MealDialogAction.delete:
        entries.remove(key);
        break;

      case MealDialogAction.cancel:
        refresh();
        return;
    }

    await StorageService.saveEntries(entries);
    refresh();
  }
}