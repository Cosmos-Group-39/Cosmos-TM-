// // // // // import 'package:cosmos_client/Constants.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // // class TrackingTemp extends StatefulWidget {
// // // // //   const TrackingTemp({super.key});

// // // // //   @override
// // // // //   State<TrackingTemp> createState() => _TrackingTempState();
// // // // // }

// // // // // class _TrackingTempState extends State<TrackingTemp> {
// // // // //   double progressValue = 0.6;
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text('Live Tracking'),
// // // // //         centerTitle: true,
// // // // //         backgroundColor: kPrimaryColor,
// // // // //         shape: const RoundedRectangleBorder(
// // // // //             borderRadius: BorderRadius.only(
// // // // //           bottomLeft: Radius.circular(50),
// // // // //           bottomRight: Radius.circular(50),
// // // // //         )),
// // // // //       ),
// // // // //       body: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.start,
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: <Widget>[
// // // // //           const SizedBox(height: 20),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(15.0),
// // // // //             child: Row(
// // // // //               mainAxisAlignment: MainAxisAlignment.start,
// // // // //               children: <Widget>[
// // // // //                 const Text(
// // // // //                   'ORDER ',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     letterSpacing: 1,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.black,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const Icon(Icons.navigate_next_sharp, size: 25, weight: 30),
// // // // //                 TextButton(onPressed: () {}, child: const Text('Order No.  ')),
// // // // //                 IconButton(
// // // // //                     onPressed: () {}, icon: const Icon(Icons.build_sharp))
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: 20),
// // // // //           Row(
// // // // //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // // //             children: [
// // // // //               ElevatedButton(
// // // // //                 style: TextButton.styleFrom(
// // // // //                   backgroundColor: const Color(0xff213B6C),
// // // // //                   minimumSize: const Size(80, 50),
// // // // //                   shadowColor: Colors.black,
// // // // //                   alignment: Alignment.center,
// // // // //                 ),
// // // // //                 onPressed: () {},
// // // // //                 child: const Text(
// // // // //                   'Create Template',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 15,
// // // // //                     letterSpacing: 1,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.white,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //               ElevatedButton(
// // // // //                 style: TextButton.styleFrom(
// // // // //                   backgroundColor: const Color(0xff213B6C),
// // // // //                   minimumSize: const Size(80, 50),
// // // // //                   shadowColor: Colors.black,
// // // // //                   alignment: Alignment.center,
// // // // //                 ),
// // // // //                 onPressed: () {},
// // // // //                 child: const Text(
// // // // //                   'Review',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 15,
// // // // //                     letterSpacing: 1,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.white,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           const SizedBox(height: 20),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(8.0),
// // // // //             child: Stack(
// // // // //               children: [
// // // // //                 LinearProgressIndicator(
// // // // //                   backgroundColor: Colors.grey[300],
// // // // //                   valueColor:
// // // // //                       const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
// // // // //                   value: progressValue,
// // // // //                   minHeight: 30,
// // // // //                 ),
// // // // //                 Positioned(
// // // // //                   top: 0,
// // // // //                   bottom: 0,
// // // // //                   left: 0,
// // // // //                   right: 0,
// // // // //                   child: Center(
// // // // //                     child: Text(
// // // // //                       '${(progressValue * 100).toStringAsFixed(0)}%', // Display progress as a percentage
// // // // //                       style: const TextStyle(
// // // // //                         color: Colors.black,
// // // // //                         fontSize: 16,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
// // // // //             child: Wrap(
// // // // //               direction: Axis.vertical,
// // // // //               spacing: 15,
// // // // //               children: [
// // // // //                 ElevatedButton(
// // // // //                   style: TextButton.styleFrom(
// // // // //                     backgroundColor: const Color(0xff213B6C),
// // // // //                     minimumSize: const Size(80, 50),
// // // // //                     shadowColor: Colors.black,
// // // // //                     alignment: Alignment.center,
// // // // //                   ),
// // // // //                   onPressed: () {},
// // // // //                   child: const Text(
// // // // //                     'Add Destination',
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 15,
// // // // //                       letterSpacing: 1,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.white,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 ElevatedButton(
// // // // //                   style: TextButton.styleFrom(
// // // // //                     backgroundColor: const Color(0xff213B6C),
// // // // //                     minimumSize: const Size(80, 50),
// // // // //                     shadowColor: Colors.black,
// // // // //                     alignment: Alignment.center,
// // // // //                   ),
// // // // //                   onPressed: () {},
// // // // //                   child: const Text(
// // // // //                     'Strat Location',
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 15,
// // // // //                       letterSpacing: 1,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.white,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 ElevatedButton(
// // // // //                   style: TextButton.styleFrom(
// // // // //                     backgroundColor: const Color(0xff213B6C),
// // // // //                     minimumSize: const Size(80, 50),
// // // // //                     shadowColor: Colors.black,
// // // // //                     alignment: Alignment.center,
// // // // //                   ),
// // // // //                   onPressed: () {},
// // // // //                   child: const Text(
// // // // //                     'Request User Destination',
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 15,
// // // // //                       letterSpacing: 1,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.white,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // // // //             child: Container(
// // // // //               width: MediaQuery.of(context).size.width,
// // // // //               height: MediaQuery.of(context).size.height / 3,
// // // // //               child: GoogleMap(
// // // // //                 initialCameraPosition: const CameraPosition(
// // // // //                   target:
// // // // //                       LatLng(37.77483, -122.41942), // San Francisco coordinates
// // // // //                   zoom: 12.0,
// // // // //                 ),
// // // // //                 markers: Set<Marker>.of([
// // // // //                   const Marker(
// // // // //                     markerId: MarkerId('marker_1'),
// // // // //                     position: LatLng(37.77483, -122.41942),
// // // // //                     infoWindow: InfoWindow(
// // // // //                       title: 'San Francisco',
// // // // //                     ),
// // // // //                   ),
// // // // //                 ]),
// // // // //               ),
// // // // //             ),
// // // // //           )
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // class CalendarWidget extends StatefulWidget {
// // // //   @override
// // // //   _CalendarWidgetState createState() => _CalendarWidgetState();
// // // // }

// // // // class _CalendarWidgetState extends State<CalendarWidget> {
// // // //   CalendarFormat _calendarFormat = CalendarFormat.month;
// // // //   DateTime _selectedDay = DateTime.now();
// // // //   DateTime _focusedDay = DateTime.now();
// // // //   Map<DateTime, List<dynamic>> _events = {};

// // // //   TextEditingController _eventController = TextEditingController();

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       body: Column(
// // // //         children: [
// // // //           TableCalendar(
// // // //             firstDay: DateTime.utc(2020, 1, 1),
// // // //             lastDay: DateTime.utc(2030, 12, 31),
// // // //             focusedDay: _focusedDay,
// // // //             calendarFormat: _calendarFormat,
// // // //             selectedDayPredicate: (day) {
// // // //               return isSameDay(_selectedDay, day);
// // // //             },
// // // //             onFormatChanged: (format) {
// // // //               setState(() {
// // // //                 _calendarFormat = format;
// // // //               });
// // // //             },
// // // //             onDaySelected: (selectedDay, focusedDay) {
// // // //               setState(() {
// // // //                 _selectedDay = selectedDay;
// // // //                 _focusedDay = focusedDay;
// // // //               });
// // // //             },
// // // //             calendarStyle: const CalendarStyle(
// // // //               selectedDecoration: BoxDecoration(
// // // //                 color: Colors.blue,
// // // //                 shape: BoxShape.circle,
// // // //               ),
// // // //               todayDecoration: BoxDecoration(
// // // //                 color: Colors.red,
// // // //                 shape: BoxShape.circle,
// // // //               ),
// // // //             ),
// // // //             calendarBuilders: CalendarBuilders(
// // // //               markerBuilder: (context, date, events) {
// // // //                 if (events.isNotEmpty) {
// // // //                   return Positioned(
// // // //                     right: 1,
// // // //                     bottom: 1,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.all(2),
// // // //                       decoration: const BoxDecoration(
// // // //                         shape: BoxShape.circle,
// // // //                         color: Colors.blue,
// // // //                       ),
// // // //                       child: Text(
// // // //                         '${events.length}',
// // // //                         style: const TextStyle(
// // // //                           color: Colors.white,
// // // //                           fontSize: 12,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   );
// // // //                 }
// // // //                 return const SizedBox();
// // // //               },
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 10),
// // // //           Text(
// // // //             'Selected Day: ${_selectedDay.toString().split(' ')[0]}',
// // // //             style: const TextStyle(fontSize: 18),
// // // //           ),
// // // //           const SizedBox(height: 10),
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(16.0),
// // // //             child: TextField(
// // // //               controller: _eventController,
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'Event',
// // // //                 suffixIcon: IconButton(
// // // //                   icon: const Icon(Icons.add),
// // // //                   onPressed: () {
// // // //                     setState(() {
// // // //                       if (_events[_selectedDay] != null) {
// // // //                         _events[_selectedDay]!.add(_eventController.text);
// // // //                       } else {
// // // //                         _events[_selectedDay] = [_eventController.text];
// // // //                       }
// // // //                       _eventController.clear();
// // // //                     });
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Expanded(
// // // //             child: ListView.builder(
// // // //               itemCount: _events[_selectedDay]?.length ?? 0,
// // // //               itemBuilder: (BuildContext context, int index) {
// // // //                 return ListTile(
// // // //                   title: Text(_events[_selectedDay]![index]),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_charts/flutter_charts.dart';

// // // class ChartView extends StatelessWidget {
// // //   final List<double> data = [9.0, 4.0, 3.0, 9.0];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       height: 500,
// // //       child: LineChart(
// // //         lines: [
// // //           Line<Point<double>>(
// // //             data: data.map((value) => Point(value)).toList(),
// // //             stroke: PaintOptions.stroke(color: Colors.blue),
// // //             marker: MarkerOptions(
// // //               paint: PaintOptions.fill(color: Colors.blue),
// // //               size: 4,
// // //             ),
// // //           ),
// // //         ],
// // //         minX: 0,
// // //         maxX: data.length.toDouble() - 1,
// // //         minY: 0,
// // //         maxY: data.reduce((maxValue, value) => value > maxValue ? value : maxValue),
// // //         chartPadding: EdgeInsets.all(16),
// // //         useDecimalScale: true,
// // //         verticalGridStep: 5,
// // //         horizontalGridStep: 4,
// // //       ),
// // //     );
// // //   }
// // // }

// import 'package:flutter/material.dart';
// import 'package:searchbase/searchbase.dart';
// import 'package:flutter_searchbox/flutter_searchbox.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_to_text_provider.dart' as stp;
// import 'package:flutter/src/material/search_anchor.dart' as FlutterSearch;
// import 'package:searchbase/src/searchcontroller.dart';

// class HomePage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SearchBox Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   // Invoke the Search Delegate to display search UI with autosuggestions
//                   showSearch(
//                       context: context,
//                       // SearchBox widget from flutter searchbox
//                       delegate: SearchBox(
//                         // A unique identifier that can be used by other widgetss to reactively update data
//                         id: 'search-widget',
//                         enableRecentSearches: true,
//                         enablePopularSuggestions: true,
//                         showAutoFill: true,
//                         maxPopularSuggestions: 3,
//                         size: 10,
//                         dataField: [
//                           {'field': 'original_title', 'weight': 1},
//                           {'field': 'original_title.search', 'weight': 3}
//                         ],
//                         // pass the speech to text instance to enable voice search
//                         speechToTextInstance: null,
//                       ));
//                 }),
//           ],
//           title: Text('SearchBox Demo'),
//         ),
//         body: Center(
//           // A custom UI widget to render a list of results
//           child: SearchWidgetConnector(
//               id: 'result-widget',
//               dataField: 'original_title',
//               react: {
//                 'and': ['search-widget'],
//               },
//               size: 10,
//               triggerQueryOnInit: true,
//               preserveResults: true,
//               builder: (context, searchController) =>
//                   ResultsWidget(searchController)),
//         ),
//       ),
//     );
//   }
// }

// class ResultsWidget extends StatelessWidget {
//   final searchController;
//   ResultsWidget(this.searchController);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               color: Colors.white,
//               height: 20,
//               child: Text(
//                   '${searchController.results.numberOfResults} results found in ${searchController.results.time.toString()} ms'),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 var offset = (searchController.from != null
//                         ? searchController.from
//                         : 0) +
//                     searchController.size;
//                 if (index == offset - 1) {
//                   if (searchController.results.numberOfResults > offset) {
//                     // Load next set of results
//                     searchController.setFrom(offset,
//                         options: Options(triggerDefaultQuery: true));
//                   }
//                 }
//               });

//               return Container(
//                   child: (index < searchController.results.data.length)
//                       ? Container(
//                           margin: const EdgeInsets.all(0.5),
//                           padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                           decoration: new BoxDecoration(
//                               border: Border.all(color: Colors.black26)),
//                           height: 200,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   children: [
//                                     Card(
//                                       semanticContainer: true,
//                                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                                       child: Image.network(
//                                         searchController.results.data[index]
//                                             ["image_medium"],
//                                         fit: BoxFit.fill,
//                                       ),
//                                       elevation: 5,
//                                       margin: EdgeInsets.all(10),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 7,
//                                 child: Column(
//                                   children: [
//                                     Column(
//                                       children: [
//                                         SizedBox(
//                                           height: 110,
//                                           width: 280,
//                                           child: ListTile(
//                                             title: Tooltip(
//                                               padding: EdgeInsets.all(5),
//                                               height: 35,
//                                               textStyle: TextStyle(
//                                                   fontSize: 15,
//                                                   color: Colors.grey,
//                                                   fontWeight:
//                                                       FontWeight.normal),
//                                               decoration: BoxDecoration(
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey,
//                                                     spreadRadius: 1,
//                                                     blurRadius: 1,
//                                                     offset: Offset(0, 1),
//                                                   ),
//                                                 ],
//                                                 color: Colors.white,
//                                               ),
//                                               message:
//                                                   'By: ${searchController.results.data[index]["original_title"]}',
//                                               child: Text(
//                                                 searchController
//                                                             .results
//                                                             .data[index][
//                                                                 "original_title"]
//                                                             .length <
//                                                         40
//                                                     ? searchController
//                                                             .results.data[index]
//                                                         ["original_title"]
//                                                     : '${searchController.results.data[index]["original_title"].substring(0, 39)}...',
//                                                 style: TextStyle(
//                                                   fontSize: 20.0,
//                                                 ),
//                                               ),
//                                             ),
//                                             subtitle: Tooltip(
//                                               padding: EdgeInsets.all(5),
//                                               height: 35,
//                                               textStyle: TextStyle(
//                                                   fontSize: 15,
//                                                   color: Colors.grey,
//                                                   fontWeight:
//                                                       FontWeight.normal),
//                                               decoration: BoxDecoration(
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey,
//                                                     spreadRadius: 1,
//                                                     blurRadius: 1,
//                                                     offset: Offset(0, 1),
//                                                   ),
//                                                 ],
//                                                 color: Colors.white,
//                                               ),
//                                               message:
//                                                   'By: ${searchController.results.data[index]["authors"]}',
//                                               child: Text(
//                                                 searchController
//                                                             .results
//                                                             .data[index]
//                                                                 ["authors"]
//                                                             .length >
//                                                         50
//                                                     ? 'By: ${searchController.results.data[index]["authors"].substring(0, 49)}...'
//                                                     : 'By: ${searchController.results.data[index]["authors"]}',
//                                                 style: TextStyle(
//                                                   fontSize: 15.0,
//                                                 ),
//                                               ),
//                                             ),
//                                             isThreeLine: true,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       25, 0, 0, 0),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 5, 0, 0),
//                                               child: Text(
//                                                 '(${searchController.results.data[index]["average_rating"]} avg)',
//                                                 style: TextStyle(
//                                                   fontSize: 12.0,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       27, 10, 0, 0),
//                                               child: Text(
//                                                 'Pub: ${searchController.results.data[index]["original_publication_year"]}',
//                                                 style: TextStyle(
//                                                   fontSize: 12.0,
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : (searchController.requestPending
//                           ? Center(child: CircularProgressIndicator())
//                           : ListTile(
//                               title: Center(
//                                 child: RichText(
//                                   text: TextSpan(
//                                     text:
//                                         searchController.results.data.length > 0
//                                             ? "No more results"
//                                             : 'No results found',
//                                     style: TextStyle(
//                                         color: Colors.black54,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             )));
//             },
//             itemCount: searchController.results.data.length + 1,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:cosmos_client/Constants.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchValue = '';
  final List<String> _suggestions = [
    'Afeganistan',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            drawer: Drawer(
                child: ListView(padding: EdgeInsets.zero, children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                  title: const Text('Item 1'),
                  onTap: () => Navigator.pop(context)),
              ListTile(
                  title: const Text('Item 2'),
                  onTap: () => Navigator.pop(context))
            ])),
            body: Column(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 45, bottom: 45, left: 25, right: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: EasySearchBar(
                      title: const Text('Access Code,Phone Number or Email'),
                      backgroundColor: Colors.white60,
                      onSearch: (value) => setState(() => searchValue = value),
                      suggestions: _suggestions),
                ),
                Center(child: Text('Value: $searchValue')),
              ],
            )));
  }
}
