import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  // Qui salviamo il tipo di alimento scelto per ogni giorno
  final Map<DateTime, String> _entries = {};

  Future<void> _showChoiceDialog(DateTime day) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Registra la giornata"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text("🌱"),
              title: const Text("Nessuna carne"),
              onTap: () => Navigator.pop(context, "none"),
            ),
            ListTile(
              leading: const Text("🥩"),
              title: const Text("Carne rossa"),
              onTap: () => Navigator.pop(context, "red"),
            ),
            ListTile(
              leading: const Text("🍗"),
              title: const Text("Carne bianca"),
              onTap: () => Navigator.pop(context, "white"),
            ),
            ListTile(
              leading: const Text("🥓"),
              title: const Text("Salumi"),
              onTap: () => Navigator.pop(context, "salumi"),
            ),
            ListTile(
              leading: const Text("🐟"),
              title: const Text("Pesce"),
              onTap: () => Navigator.pop(context, "fish"),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _entries[DateTime(day.year, day.month, day.day)] = result;
      });
    }
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

            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              _showChoiceDialog(selectedDay);
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final key = DateTime(day.year, day.month, day.day);

                if (_entries.containsKey(key)) {
                  final green = _entries[key] == "none";

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
                }

                return null;
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