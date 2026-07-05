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
    required Map<DateTime, MealType> entries,
    required VoidCallback refresh,
    required Function(DateTime) updateFocusedDay,
    required Function(DateTime?) updateSelectedDay,
  }) async {
    updateSelectedDay(selectedDay);
    updateFocusedDay(focusedDay);

    final result = await showMealChoiceDialog(context);

    if (result == null) {
      refresh();
      return;
    }

    final key = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    switch (result.action) {
      case MealDialogAction.select:
        entries[key] = result.mealType!;
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