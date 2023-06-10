// import 'package:cosmos_client/Constants.dart';
// import 'package:easy_search_bar/easy_search_bar.dart';
// import 'package:flutter/material.dart';

// Widget workflowsSearch() {
//   String searchValue = '';
//   final List<String> _suggestions = [
//     'Afeganistan',
//     'Albania',
//     'Algeria',
//     'Australia',
//     'Brazil',
//     'German',
//     'Madagascar',
//     'Mozambique',
//     'Portugal',
//     'Zambia'
//   ];
//   return Container(
//     height: 50,
//     width: MediaQuery.of(context).size.width,
//     alignment: Alignment.center,
//     margin: const EdgeInsets.only(top: 45, bottom: 45, left: 25, right: 25),
//     padding: const EdgeInsets.symmetric(horizontal: 11),
//     decoration: BoxDecoration(
//       color: kBackgroundColor,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: const [
//         BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
//       ],
//     ),
//     child: EasySearchBar(
//         title: const Text('Access code, Email or Phone number'),
//         backgroundColor: Colors.white60,
//         onSearch: (value) => setState(() => searchValue = value),
//         suggestions: _suggestions),
//   );
// }
