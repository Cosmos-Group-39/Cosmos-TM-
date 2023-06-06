import 'package:flutter/material.dart';

orgHomeText(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            const TextSpan(
              text: 'Welcome to Cosmos™\n\n',
              style: TextStyle(
                  fontSize: 18,
                  color: kDefaultIconDarkColor,
                  decoration: TextDecoration.none),
            ),
            TextSpan(
              text:
                  'Stay connected, informed and engaged\nwith our mobile app.\n',
              style: TextStyle(
                  fontSize: 12,
                  color: kDefaultIconDarkColor.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    ],
  );
}

orgCreatedText(BuildContext context) {
  return Column(
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            const TextSpan(
              text: 'Created organizations in Cosmos™\n\n',
              style: TextStyle(
                  fontSize: 18,
                  color: kDefaultIconDarkColor,
                  decoration: TextDecoration.none),
            ),
            TextSpan(
              text: 'Select an Organization.\n',
              style: TextStyle(
                  fontSize: 12,
                  color: kDefaultIconDarkColor.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    ],
  );
}

orgAddMmeberText(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            const TextSpan(
              text: 'Add members to your organization\n\n',
              style: TextStyle(
                  fontSize: 16,
                  color: kDefaultIconDarkColor,
                  decoration: TextDecoration.none),
            ),
            TextSpan(
              text: 'Search members.\n\nSet their roles.',
              style: TextStyle(
                  fontSize: 12,
                  color: kDefaultIconDarkColor.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    ],
  );
}

orgFormText(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: const <TextSpan>[
            TextSpan(
              text: 'Please fill out all fields in the form\n',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    ],
  );
}
