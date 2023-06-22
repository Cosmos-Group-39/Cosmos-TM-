import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderViewScreen extends StatefulWidget {
  dynamic subworkflow;
  final String workflowName;
  final Function(dynamic) onDelete;
  CalenderViewScreen(
      {super.key,
      required this.subworkflow,
      required this.workflowName,
      required this.onDelete});

  @override
  _CalenderViewScreenState createState() => _CalenderViewScreenState();
}

class _CalenderViewScreenState extends State<CalenderViewScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};

  TextEditingController _eventController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //Delete calender view
  deleteCalender() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          title: const Icon(
            Icons.delete,
            size: 60.0,
            color: Colors.green,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are You Sure ?',
                  style: kAlertBoxTopicTextStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 17),
                  child: Text(
                    'You want to delete Calender !',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: kAlertBoxButtonStyle,
                  onPressed: () {
                    widget.onDelete(widget.subworkflow);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: kAlertBoxButtonTextStyle,
                  ),
                ),
                ElevatedButton(
                  style: kAlertBoxButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: kAlertBoxButtonTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.subworkflow['title']);
    print(widget.subworkflow['description']);
    print(widget.subworkflow);
    _titleController.text = widget.subworkflow['title'];
    _descriptionController.text = widget.subworkflow['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workflowName),
      ),
      body: buildCalendarWidget(),
    );
  }

  Widget buildCalendarWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.create),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                  onPressed: deleteCalender, icon: const Icon(Icons.delete))
            ],
          ),
        ),
        const SizedBox(height: 8),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: const CalendarStyle(
            markerDecoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Text(
                      '${events.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Selected Day: ${_selectedDay.toString().split(' ')[0]}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _eventController,
            decoration: InputDecoration(
              labelText: 'Event',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    if (_events[_selectedDay] != null) {
                      _events[_selectedDay]!.add(_eventController.text);
                    } else {
                      _events[_selectedDay] = [_eventController.text];
                    }
                    print(_events);
                    _eventController.clear();
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _events[_selectedDay]?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_events[_selectedDay]![index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
