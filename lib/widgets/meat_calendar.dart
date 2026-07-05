import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/meal_type.dart';
import 'day_widget.dart';

class MeatCalendar extends StatelessWidget {
  const MeatCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.entries,
    required this.onDaySelected,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<MealType>> entries;

  final Future<void> Function(DateTime, DateTime) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: focusedDay,

      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
      ),

      selectedDayPredicate: (day) =>
          isSameDay(selectedDay, day),

      onDaySelected: onDaySelected,

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) =>
            buildDay(day, entries, selectedDay),

        todayBuilder: (context, day, focusedDay) =>
            buildDay(day, entries, selectedDay),

        selectedBuilder: (context, day, focusedDay) =>
            buildDay(day, entries, selectedDay),
      ),
    );
  }
}