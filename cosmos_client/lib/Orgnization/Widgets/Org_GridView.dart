import 'package:cosmos_client/Constants.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Form.dart';
import 'package:cosmos_client/Orgnization/Screens/Org_Settings.dart';
import 'package:cosmos_client/Orgnization/Screens/Your_Org.dart';
import 'package:flutter/material.dart';

Widget orgGridView(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 40, crossAxisSpacing: 25),
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrgForm()));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.1),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline,
                      color: kPrimaryColor, size: 50),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Create New',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            wordSpacing: 2)),
                  ),
                ]),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateCards()));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.1),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_rounded, color: kPrimaryColor, size: 50),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Your Organizations',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            wordSpacing: 2)),
                  ),
                ]),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.1),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feedback, color: kPrimaryColor, size: 50),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Rate Us',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            wordSpacing: 2)),
                  ),
                ]),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrgSettings()));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.1),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help, color: kPrimaryColor, size: 50),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                    child: Text('Help & Tips',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            wordSpacing: 2)),
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}
