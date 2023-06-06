import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Models/FormValidation.dart';
import 'package:flutter/material.dart';

class OrgSearch extends StatefulWidget {
  const OrgSearch({super.key});

  @override
  _OrgSearchState createState() => _OrgSearchState();
}

class _OrgSearchState extends State<OrgSearch> {
  TextEditingController _searchController = TextEditingController();
  List<FormModel> cardsx = []; // Replace with your actual list of cards

  void _performSearch(String searchText) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Populate the _allCards list with your actual data
    cardsx = [
      FormModel(
          cardID: "1",
          cardName: "Card A",
          description: "Description of Card A",
          profilePic: ''),
      FormModel(
          cardID: "2",
          cardName: "Card B",
          description: "Description of Card B",
          profilePic: ''),
      FormModel(
          cardID: "3",
          cardName: "Card C",
          description: "Description of Card C",
          profilePic: ''),
      FormModel(
          cardID: "4",
          cardName: "Card D",
          description: "Description of Card D",
          profilePic: ''),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 45, bottom: 45, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: kTextPadding),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: TextField(
        controller: _searchController,
        keyboardType: TextInputType.name,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'Search Organizations...',
          hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // ignore: prefer_const_constructors
          suffixIcon: Icon(
            Icons.search_rounded,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
