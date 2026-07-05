import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/meal_type.dart';
import '../services/storage_service.dart';
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
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final loadedEntries = await StorageService.loadEntries();

    setState(() {
      _entries.clear();
      _entries.addAll(loadedEntries);
    });
  }

  Widget _buildDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);

    Color? color;

    if (_entries.containsKey(key)) {
      color = _entries[key] == MealType.none
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

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),

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

                await StorageService.saveEntries(_entries);
              }
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) =>
                  _buildDay(day),

              todayBuilder: (context, day, focusedDay) =>
                  _buildDay(day),

              selectedBuilder: (context, day, focusedDay) =>
                  _buildDay(day),
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