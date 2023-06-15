import 'package:cosmos_client/Workflow%20Management/View%20Cards/calenderViewCard.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cosmos_client/Chat/Screen/chat_group.dart';
import 'package:cosmos_client/Workflow%20Management/Screens/yourSubWorkflow.dart';
import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Workflow%20Management/Models/workflowModels.dart';
import 'package:uuid/uuid.dart';

class CalenderWorksScreen extends StatefulWidget {
  const CalenderWorksScreen({Key? key}) : super(key: key);

  @override
  State<CalenderWorksScreen> createState() => _CalenderWorksScreenState();
}

class _CalenderWorksScreenState extends State<CalenderWorksScreen> {
  List<WorksModel> workcards = [];
  Uuid uuid = Uuid();
  TextEditingController _workController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _workController.dispose();
    super.dispose();
  }

  void createWorks() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: kAlertBoxBorderStyle,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create Work',
                  style: kAlertBoxTopicTextStyle,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.add,
                  size: 60.0,
                  color: Colors.green,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _workController,
                  decoration: const InputDecoration(
                    hintText: 'Work Name',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: kAlertBoxButtonStyle,
                onPressed: () {
                  String title = _workController.text.trim();
                  String wwid = uuid.v4();
                  WorksModel work_newItem = WorksModel(
                    wwid: wwid,
                    title: title,
                  );

                  setState(() {
                    workcards.add(work_newItem);
                  });

                  Navigator.pop(context);
                  _workController.clear();
                },
                child: const Text(
                  'Create',
                  style: kAlertBoxButtonTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void deleteWorks(String wwid) {
    setState(() {
      workcards.removeWhere((element) => element.wwid == wwid);
    });
  }

  void editWorks(WorksModel editedItem) {
    setState(() {
      int index =
          workcards.indexWhere((element) => element.wwid == editedItem.wwid);
      workcards[index] = editedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'Works',
            style: kAppBarTitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatedSubWorkflows()));
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupPage(
                              name: '',
                              userId: '',
                            )));
              },
              child: const Icon(Icons.chat_bubble),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the desired radius here
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () => createWorks(),
          child: const Icon(Icons.add),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'End Semester Exam',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  SizedBox(height: 25),
                  Container(height: 550, child: buildCalendarWidget()),
                  const SizedBox(height: 15),
                  Container(
                    height: 300,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: workcards.length,
                        itemBuilder: (context, index) {
                          return CalenderWorksCard(
                            item: workcards[index],
                            workonDelete: (wwid) => deleteWorks(wwid),
                            workonEdit: (editedItem) => editWorks(editedItem),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCalendarWidget() {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _selectedDay = DateTime.now();
    DateTime _focusedDay = DateTime.now();
    Map<DateTime, List<dynamic>> _events = {};

    TextEditingController _eventController = TextEditingController();
    return Column(
      children: [
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
          // // Event loader to provide the events for each day
          // eventLoader: (day) {
          //   return _events[day] ?? [];
          // },
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
