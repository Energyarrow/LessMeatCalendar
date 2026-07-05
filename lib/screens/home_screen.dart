import 'package:flutter/material.dart';

import '../models/meal_type.dart';
import '../services/home_controller.dart';
import '../services/storage_service.dart';
import '../widgets/meat_calendar.dart';
import '../widgets/selected_day_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌱 LessMeatCalendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MeatCalendar(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            entries: _entries,
            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),

          SelectedDayCard(
            selectedDay: _selectedDay,
            entries: _entries,
            onPressed: () async {
              if (_selectedDay == null) return;

              await HomeController.onDaySelected(
                context: context,
                selectedDay: _selectedDay!,
                focusedDay: _focusedDay,
                entries: _entries,
                updateFocusedDay: (day) => _focusedDay = day,
                updateSelectedDay: (day) => _selectedDay = day,
                refresh: () => setState(() {}),
              );
            },
          ),
        ],
      ),
    );
  }
}