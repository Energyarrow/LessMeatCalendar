import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MeatCalendar extends StatelessWidget {
  const MeatCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.calendarBuilders,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;

  final void Function(DateTime, DateTime) onDaySelected;

  final CalendarBuilders calendarBuilders;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: focusedDay,

      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },

      onDaySelected: onDaySelected,

      calendarBuilders: calendarBuilders,
    );
  }
}