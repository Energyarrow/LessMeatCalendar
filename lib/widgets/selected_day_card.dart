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
  final Map<DateTime, List<MealType>> entries;
  final VoidCallback onPressed;

  String _mealText(MealType meal) {
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

    final meals = entries[key];

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "${selectedDay!.day}/${selectedDay!.month}/${selectedDay!.year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (meals == null || meals.isEmpty)
              const Center(
                child: Text(
                  "Nessuna registrazione",
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              ...meals.map(
                    (meal) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    _mealText(meal),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  meals == null || meals.isEmpty
                      ? Icons.add
                      : Icons.edit,
                ),
                label: Text(
                  meals == null || meals.isEmpty
                      ? "Registra"
                      : "Modifica",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}