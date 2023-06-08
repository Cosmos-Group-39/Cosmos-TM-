import 'package:cosmos_client/Constants.dart';
import 'package:flutter/material.dart';

typedef MemberSearchCallback = void Function(String query);

Widget orgMemberSearch(
    BuildContext context, MemberSearchCallback onSearch, bool showResults) {
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
        ]),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: 'Search Members...',
              hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_rounded,
            color: kPrimaryColor,
          ),
        ),
      ],
    ),
  );
}
