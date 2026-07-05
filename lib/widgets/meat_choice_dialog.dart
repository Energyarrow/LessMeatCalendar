import 'package:flutter/material.dart';

import '../models/meal_dialog_result.dart';
import '../models/meal_type.dart';

Future<MealDialogResult?> showMealChoiceDialog(
    BuildContext context,
    List<MealType> initialMeals,
    ) {
  final selectedMeals = initialMeals.toSet();

  return showDialog<MealDialogResult>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void toggle(MealType meal) {
            setState(() {
              if (meal == MealType.none) {
                if (selectedMeals.contains(MealType.none)) {
                  selectedMeals.remove(MealType.none);
                } else {
                  selectedMeals
                    ..clear()
                    ..add(MealType.none);
                }
              } else {
                selectedMeals.remove(MealType.none);

                if (selectedMeals.contains(meal)) {
                  selectedMeals.remove(meal);
                } else {
                  selectedMeals.add(meal);
                }
              }
            });
          }

          return AlertDialog(
            title: const Text("What did you eat?"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    value: selectedMeals.contains(MealType.none),
                    title: const Text("🌱 Meat-free"),
                    onChanged: (_) => toggle(MealType.none),
                  ),
                  CheckboxListTile(
                    value: selectedMeals.contains(MealType.redMeat),
                    title: const Text("🥩 Red meat"),
                    onChanged: (_) => toggle(MealType.redMeat),
                  ),
                  CheckboxListTile(
                    value: selectedMeals.contains(MealType.whiteMeat),
                    title: const Text("🍗 White meat"),
                    onChanged: (_) => toggle(MealType.whiteMeat),
                  ),
                  CheckboxListTile(
                    value: selectedMeals.contains(MealType.salumi),
                    title: const Text("🥓 Processed meat"),
                    onChanged: (_) => toggle(MealType.salumi),
                  ),
                  CheckboxListTile(
                    value: selectedMeals.contains(MealType.fish),
                    title: const Text("🐟 Fish"),
                    onChanged: (_) => toggle(MealType.fish),
                  ),

                  const SizedBox(height: 10),
                  const Divider(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Save"),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MealDialogResult.select(
                            selectedMeals.toList(),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      label: const Text("Delete Entry"),
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
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}