// // // import 'package:cosmos_client/Constants.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // class TrackingTemp extends StatefulWidget {
// // //   const TrackingTemp({super.key});

// // //   @override
// // //   State<TrackingTemp> createState() => _TrackingTempState();
// // // }

// // // class _TrackingTempState extends State<TrackingTemp> {
// // //   double progressValue = 0.6;
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Live Tracking'),
// // //         centerTitle: true,
// // //         backgroundColor: kPrimaryColor,
// // //         shape: const RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.only(
// // //           bottomLeft: Radius.circular(50),
// // //           bottomRight: Radius.circular(50),
// // //         )),
// // //       ),
// // //       body: Column(
// // //         mainAxisAlignment: MainAxisAlignment.start,
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: <Widget>[
// // //           const SizedBox(height: 20),
// // //           Padding(
// // //             padding: const EdgeInsets.all(15.0),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.start,
// // //               children: <Widget>[
// // //                 const Text(
// // //                   'ORDER ',
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     letterSpacing: 1,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.black,
// // //                   ),
// // //                 ),
// // //                 const Icon(Icons.navigate_next_sharp, size: 25, weight: 30),
// // //                 TextButton(onPressed: () {}, child: const Text('Order No.  ')),
// // //                 IconButton(
// // //                     onPressed: () {}, icon: const Icon(Icons.build_sharp))
// // //               ],
// // //             ),
// // //           ),
// // //           const SizedBox(height: 20),
// // //           Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //             children: [
// // //               ElevatedButton(
// // //                 style: TextButton.styleFrom(
// // //                   backgroundColor: const Color(0xff213B6C),
// // //                   minimumSize: const Size(80, 50),
// // //                   shadowColor: Colors.black,
// // //                   alignment: Alignment.center,
// // //                 ),
// // //                 onPressed: () {},
// // //                 child: const Text(
// // //                   'Create Template',
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     letterSpacing: 1,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //               ),
// // //               ElevatedButton(
// // //                 style: TextButton.styleFrom(
// // //                   backgroundColor: const Color(0xff213B6C),
// // //                   minimumSize: const Size(80, 50),
// // //                   shadowColor: Colors.black,
// // //                   alignment: Alignment.center,
// // //                 ),
// // //                 onPressed: () {},
// // //                 child: const Text(
// // //                   'Review',
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     letterSpacing: 1,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 20),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: Stack(
// // //               children: [
// // //                 LinearProgressIndicator(
// // //                   backgroundColor: Colors.grey[300],
// // //                   valueColor:
// // //                       const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
// // //                   value: progressValue,
// // //                   minHeight: 30,
// // //                 ),
// // //                 Positioned(
// // //                   top: 0,
// // //                   bottom: 0,
// // //                   left: 0,
// // //                   right: 0,
// // //                   child: Center(
// // //                     child: Text(
// // //                       '${(progressValue * 100).toStringAsFixed(0)}%', // Display progress as a percentage
// // //                       style: const TextStyle(
// // //                         color: Colors.black,
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
// // //             child: Wrap(
// // //               direction: Axis.vertical,
// // //               spacing: 15,
// // //               children: [
// // //                 ElevatedButton(
// // //                   style: TextButton.styleFrom(
// // //                     backgroundColor: const Color(0xff213B6C),
// // //                     minimumSize: const Size(80, 50),
// // //                     shadowColor: Colors.black,
// // //                     alignment: Alignment.center,
// // //                   ),
// // //                   onPressed: () {},
// // //                   child: const Text(
// // //                     'Add Destination',
// // //                     style: TextStyle(
// // //                       fontSize: 15,
// // //                       letterSpacing: 1,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Colors.white,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 ElevatedButton(
// // //                   style: TextButton.styleFrom(
// // //                     backgroundColor: const Color(0xff213B6C),
// // //                     minimumSize: const Size(80, 50),
// // //                     shadowColor: Colors.black,
// // //                     alignment: Alignment.center,
// // //                   ),
// // //                   onPressed: () {},
// // //                   child: const Text(
// // //                     'Strat Location',
// // //                     style: TextStyle(
// // //                       fontSize: 15,
// // //                       letterSpacing: 1,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Colors.white,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 ElevatedButton(
// // //                   style: TextButton.styleFrom(
// // //                     backgroundColor: const Color(0xff213B6C),
// // //                     minimumSize: const Size(80, 50),
// // //                     shadowColor: Colors.black,
// // //                     alignment: Alignment.center,
// // //                   ),
// // //                   onPressed: () {},
// // //                   child: const Text(
// // //                     'Request User Destination',
// // //                     style: TextStyle(
// // //                       fontSize: 15,
// // //                       letterSpacing: 1,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Colors.white,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // //             child: Container(
// // //               width: MediaQuery.of(context).size.width,
// // //               height: MediaQuery.of(context).size.height / 3,
// // //               child: GoogleMap(
// // //                 initialCameraPosition: const CameraPosition(
// // //                   target:
// // //                       LatLng(37.77483, -122.41942), // San Francisco coordinates
// // //                   zoom: 12.0,
// // //                 ),
// // //                 markers: Set<Marker>.of([
// // //                   const Marker(
// // //                     markerId: MarkerId('marker_1'),
// // //                     position: LatLng(37.77483, -122.41942),
// // //                     infoWindow: InfoWindow(
// // //                       title: 'San Francisco',
// // //                     ),
// // //                   ),
// // //                 ]),
// // //               ),
// // //             ),
// // //           )
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // class CalendarWidget extends StatefulWidget {
// //   @override
// //   _CalendarWidgetState createState() => _CalendarWidgetState();
// // }

// // class _CalendarWidgetState extends State<CalendarWidget> {
// //   CalendarFormat _calendarFormat = CalendarFormat.month;
// //   DateTime _selectedDay = DateTime.now();
// //   DateTime _focusedDay = DateTime.now();
// //   Map<DateTime, List<dynamic>> _events = {};

// //   TextEditingController _eventController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           TableCalendar(
// //             firstDay: DateTime.utc(2020, 1, 1),
// //             lastDay: DateTime.utc(2030, 12, 31),
// //             focusedDay: _focusedDay,
// //             calendarFormat: _calendarFormat,
// //             selectedDayPredicate: (day) {
// //               return isSameDay(_selectedDay, day);
// //             },
// //             onFormatChanged: (format) {
// //               setState(() {
// //                 _calendarFormat = format;
// //               });
// //             },
// //             onDaySelected: (selectedDay, focusedDay) {
// //               setState(() {
// //                 _selectedDay = selectedDay;
// //                 _focusedDay = focusedDay;
// //               });
// //             },
// //             calendarStyle: const CalendarStyle(
// //               selectedDecoration: BoxDecoration(
// //                 color: Colors.blue,
// //                 shape: BoxShape.circle,
// //               ),
// //               todayDecoration: BoxDecoration(
// //                 color: Colors.red,
// //                 shape: BoxShape.circle,
// //               ),
// //             ),
// //             calendarBuilders: CalendarBuilders(
// //               markerBuilder: (context, date, events) {
// //                 if (events.isNotEmpty) {
// //                   return Positioned(
// //                     right: 1,
// //                     bottom: 1,
// //                     child: Container(
// //                       padding: const EdgeInsets.all(2),
// //                       decoration: const BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         color: Colors.blue,
// //                       ),
// //                       child: Text(
// //                         '${events.length}',
// //                         style: const TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }
// //                 return const SizedBox();
// //               },
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           Text(
// //             'Selected Day: ${_selectedDay.toString().split(' ')[0]}',
// //             style: const TextStyle(fontSize: 18),
// //           ),
// //           const SizedBox(height: 10),
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: TextField(
// //               controller: _eventController,
// //               decoration: InputDecoration(
// //                 labelText: 'Event',
// //                 suffixIcon: IconButton(
// //                   icon: const Icon(Icons.add),
// //                   onPressed: () {
// //                     setState(() {
// //                       if (_events[_selectedDay] != null) {
// //                         _events[_selectedDay]!.add(_eventController.text);
// //                       } else {
// //                         _events[_selectedDay] = [_eventController.text];
// //                       }
// //                       _eventController.clear();
// //                     });
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _events[_selectedDay]?.length ?? 0,
// //               itemBuilder: (BuildContext context, int index) {
// //                 return ListTile(
// //                   title: Text(_events[_selectedDay]![index]),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_charts/flutter_charts.dart';

// class ChartView extends StatelessWidget {
//   final List<double> data = [9.0, 4.0, 3.0, 9.0];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       child: LineChart(
//         lines: [
//           Line<Point<double>>(
//             data: data.map((value) => Point(value)).toList(),
//             stroke: PaintOptions.stroke(color: Colors.blue),
//             marker: MarkerOptions(
//               paint: PaintOptions.fill(color: Colors.blue),
//               size: 4,
//             ),
//           ),
//         ],
//         minX: 0,
//         maxX: data.length.toDouble() - 1,
//         minY: 0,
//         maxY: data.reduce((maxValue, value) => value > maxValue ? value : maxValue),
//         chartPadding: EdgeInsets.all(16),
//         useDecimalScale: true,
//         verticalGridStep: 5,
//         horizontalGridStep: 4,
//       ),
//     );
//   }
// }
