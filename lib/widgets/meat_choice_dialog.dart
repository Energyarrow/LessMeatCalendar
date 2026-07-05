import 'package:flutter/material.dart';
import '../models/meal_type.dart';

class MeatChoiceDialog extends StatelessWidget {
  const MeatChoiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Registra la giornata"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListTile(
            leading: const Text("🌱"),
            title: const Text("Nessuna carne"),
            onTap: (){
              Navigator.pop(context, MealType.none);
            },
          ),

          ListTile(
            leading: const Text("🥩"),
            title: const Text("Carne rossa"),
            onTap: (){
              Navigator.pop(context, MealType.redMeat);
            },
          ),

          ListTile(
            leading: const Text("🍗"),
            title: const Text("Carne bianca"),
            onTap: (){
              Navigator.pop(context, MealType.whiteMeat);
            },
          ),

          ListTile(
            leading: const Text("🥓"),
            title: const Text("Salumi"),
            onTap: (){
              Navigator.pop(context, MealType.curedMeat);
            },
          ),

          ListTile(
            leading: const Text("🐟"),
            title: const Text("Pesce"),
            onTap: (){
              Navigator.pop(context, MealType.fish);
            },
          ),

        ],
      ),
    );
  }
}