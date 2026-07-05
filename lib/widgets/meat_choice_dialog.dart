import 'package:flutter/material.dart';

import '../models/meal_dialog_result.dart';
import '../models/meal_type.dart';

Future<MealDialogResult?> showMealChoiceDialog(BuildContext context) {
  return showDialog<MealDialogResult>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Che cosa hai mangiato?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _mealButton(
              context,
              MealDialogResult.select(MealType.none),
              "🌱 Nessuna carne",
            ),
            _mealButton(
              context,
              MealDialogResult.select(MealType.redMeat),
              "🥩 Carne rossa",
            ),
            _mealButton(
              context,
              MealDialogResult.select(MealType.whiteMeat),
              "🍗 Carne bianca",
            ),
            _mealButton(
              context,
              MealDialogResult.select(MealType.salumi),
              "🥓 Salumi",
            ),
            _mealButton(
              context,
              MealDialogResult.select(MealType.fish),
              "🐟 Pesce",
            ),

            const SizedBox(height: 10),
            const Divider(),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text("Elimina registrazione"),
                onPressed: () {
                  Navigator.pop(
                    context,
                    const MealDialogResult.delete(),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    const MealDialogResult.cancel(),
                  );
                },
                child: const Text("Annulla"),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _mealButton(
    BuildContext context,
    MealDialogResult result,
    String text,
    ) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => Navigator.pop(context, result),
      child: Text(text),
    ),
  );
}