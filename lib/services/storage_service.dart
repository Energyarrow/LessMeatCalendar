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

  final void Function(DateTime selectedDay, DateTime focusedDay)
  onDaySelected;

  final CalendarBuilders<dynamic> calendarBuilders;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2035, 12, 31),
      focusedDay: focusedDay,

      availableCalendarFormats: const {
        CalendarFormat.month: 'Mese',
      },

      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),

      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),

      selectedDayPredicate: (day) => isSameDay(day, selectedDay),

      onDaySelected: onDaySelected,

      calendarBuilders: calendarBuilders,
    );
  }
}