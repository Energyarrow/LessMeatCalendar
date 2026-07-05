import 'package:flutter/material.dart';

import '../models/meal_type.dart';

class SelectedDayCard extends StatelessWidget {
  const SelectedDayCard({
    super.key,
    required this.selectedDay,
    required this.entries,
    required this.onPressed,
  });

  final DateTime? selectedDay;
  final Map<DateTime, MealType> entries;
  final VoidCallback onPressed;

  String _mealText(MealType? meal) {
    switch (meal) {
      case MealType.none:
        return "🌱 Nessuna carne";
      case MealType.redMeat:
        return "🥩 Carne rossa";
      case MealType.whiteMeat:
        return "🍗 Carne bianca";
      case MealType.salumi:
        return "🥓 Salumi";
      case MealType.fish:
        return "🐟 Pesce";
      case null:
        return "Nessuna registrazione";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    final key = DateTime(
      selectedDay!.year,
      selectedDay!.month,
      selectedDay!.day,
    );

    final meal = entries[key];

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "${selectedDay!.day}/${selectedDay!.month}/${selectedDay!.year}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              _mealText(meal),
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                meal == null ? Icons.add : Icons.edit,
              ),
              label: Text(
                meal == null
                    ? "Registra"
                    : "Modifica",
              ),
            ),
          ],
        ),
      ),
    );
  }
}