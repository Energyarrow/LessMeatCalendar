import 'package:flutter/material.dart';

import '../models/meal_type.dart';

Widget buildDay(
    DateTime day,
    Map<DateTime, List<MealType>> entries,
    DateTime? selectedDay,
    ) {
  final key = DateTime(day.year, day.month, day.day);

  Color? color;

  if (entries.containsKey(key)) {
    final meals = entries[key]!;

    if (meals.length == 1 && meals.contains(MealType.none)) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
  }

  final isSelected = selectedDay != null &&
      selectedDay.year == day.year &&
      selectedDay.month == day.month &&
      selectedDay.day == day.day;

  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: isSelected
          ? Border.all(
        color: Colors.black,
        width: 3,
      )
          : null,
    ),
    alignment: Alignment.center,
    child: Text(
      day.day.toString(),
      style: TextStyle(
        color: color == null ? Colors.black : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}