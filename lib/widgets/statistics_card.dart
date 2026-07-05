import 'package:flutter/material.dart';

import '../models/meal_type.dart';

Widget buildDay(
    DateTime day,
    Map<DateTime, MealType> entries,
    ) {
  final key = DateTime(day.year, day.month, day.day);

  Color? color;

  if (entries.containsKey(key)) {
    color = entries[key] == MealType.none
        ? Colors.green
        : Colors.red;
  }

  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
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