// import 'package:cosmos_client/Constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrackingTemp extends StatefulWidget {
//   const TrackingTemp({super.key});

//   @override
//   State<TrackingTemp> createState() => _TrackingTempState();
// }

// class _TrackingTempState extends State<TrackingTemp> {
//   double progressValue = 0.6;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Live Tracking'),
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         )),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 const Text(
//                   'ORDER ',
//                   style: TextStyle(
//                     fontSize: 20,
//                     letterSpacing: 1,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const Icon(Icons.navigate_next_sharp, size: 25, weight: 30),
//                 TextButton(onPressed: () {}, child: const Text('Order No.  ')),
//                 IconButton(
//                     onPressed: () {}, icon: const Icon(Icons.build_sharp))
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: const Color(0xff213B6C),
//                   minimumSize: const Size(80, 50),
//                   shadowColor: Colors.black,
//                   alignment: Alignment.center,
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'Create Template',
//                   style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 1,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: const Color(0xff213B6C),
//                   minimumSize: const Size(80, 50),
//                   shadowColor: Colors.black,
//                   alignment: Alignment.center,
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'Review',
//                   style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 1,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: [
//                 LinearProgressIndicator(
//                   backgroundColor: Colors.grey[300],
//                   valueColor:
//                       const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
//                   value: progressValue,
//                   minHeight: 30,
//                 ),
//                 Positioned(
//                   top: 0,
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Text(
//                       '${(progressValue * 100).toStringAsFixed(0)}%', // Display progress as a percentage
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//             child: Wrap(
//               direction: Axis.vertical,
//               spacing: 15,
//               children: [
//                 ElevatedButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xff213B6C),
//                     minimumSize: const Size(80, 50),
//                     shadowColor: Colors.black,
//                     alignment: Alignment.center,
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     'Add Destination',
//                     style: TextStyle(
//                       fontSize: 15,
//                       letterSpacing: 1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xff213B6C),
//                     minimumSize: const Size(80, 50),
//                     shadowColor: Colors.black,
//                     alignment: Alignment.center,
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     'Strat Location',
//                     style: TextStyle(
//                       fontSize: 15,
//                       letterSpacing: 1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xff213B6C),
//                     minimumSize: const Size(80, 50),
//                     shadowColor: Colors.black,
//                     alignment: Alignment.center,
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     'Request User Destination',
//                     style: TextStyle(
//                       fontSize: 15,
//                       letterSpacing: 1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 3,
//               child: GoogleMap(
//                 initialCameraPosition: const CameraPosition(
//                   target:
//                       LatLng(37.77483, -122.41942), // San Francisco coordinates
//                   zoom: 12.0,
//                 ),
//                 markers: Set<Marker>.of([
//                   const Marker(
//                     markerId: MarkerId('marker_1'),
//                     position: LatLng(37.77483, -122.41942),
//                     infoWindow: InfoWindow(
//                       title: 'San Francisco',
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
