import 'package:flutter/material.dart';
import '../models/meal_type.dart';

Future<MealType?> showMealChoiceDialog(BuildContext context) {
  return showDialog<MealType>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Che cosa hai mangiato?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _mealButton(context, MealType.none, "🌱 Nessuna carne"),
            _mealButton(context, MealType.redMeat, "🥩 Carne rossa"),
            _mealButton(context, MealType.whiteMeat, "🍗 Carne bianca"),
            _mealButton(context, MealType.salumi, "🥓 Salumi"),
            _mealButton(context, MealType.fish, "🐟 Pesce"),
          ],
        ),
      );
    },
  );
}

Widget _mealButton(BuildContext context, MealType type, String text) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => Navigator.pop(context, type),
      child: Text(text),
    ),
  );
}