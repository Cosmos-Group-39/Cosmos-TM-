import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

Widget workflowsSearch(BuildContext context, Function(String) onSearch) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 45, bottom: 45, left: 25, right: 25),
    padding: const EdgeInsets.symmetric(horizontal: 11),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
      ],
    ),
    child: TextField(
      controller: searchTextController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Access code, Email or Phone number',
        hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: const Icon(
          Icons.search_rounded,
          color: kPrimaryColor,
        ),
      ),
      onSubmitted: onSearch,
    ),
  );
}
