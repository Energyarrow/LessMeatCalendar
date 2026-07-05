import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/meal_type.dart';
import '../widgets/meat_choice_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  final Map<DateTime, MealType> _entries = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌱 LessMeatCalendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            focusedDay: _focusedDay,

            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),

            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              final result = await showMealChoiceDialog(context);

              if (result != null) {
                setState(() {
                  _entries[DateTime(
                    selectedDay.year,
                    selectedDay.month,
                    selectedDay.day,
                  )] = result;
                });
              }
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final key = DateTime(day.year, day.month, day.day);

                if (!_entries.containsKey(key)) {
                  return null;
                }

                final green = _entries[key] == MealType.none;

                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: green ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Tocca un giorno per registrare il consumo",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}