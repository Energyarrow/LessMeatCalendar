import 'package:flutter/material.dart';
import '../models/meal_type.dart';

class MeatChoiceDialog extends StatelessWidget {
  const MeatChoiceDialog({super.key});

  Widget _item(
      BuildContext context,
      String emoji,
      String text,
      MealType value,
      ) {
    return ListTile(
      leading: Text(
        emoji,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(text),
      onTap: () => Navigator.pop(context, value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Registra la giornata"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _item(context, "🌱", "Nessuna carne", MealType.none),
          _item(context, "🥩", "Carne rossa", MealType.redMeat),
          _item(context, "🍗", "Carne bianca", MealType.whiteMeat),
          _item(context, "🥓", "Salumi", MealType.curedMeat),
          _item(context, "🐟", "Pesce", MealType.fish),
        ],
      ),
    );
  }
}