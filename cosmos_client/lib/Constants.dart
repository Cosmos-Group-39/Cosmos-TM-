import 'package:flutter/material.dart';

//Base URL
const String baseUrls = 'http://localhost:8080/api';

//payments
String SECRET_KEY =
    "sk_test_51Mgl36DXFk3tkknrl2DxC3ogKFQdlm7ZcHntKldMLxay1Ki4dtP081vOWv5WxbAk2Q2CZlyHJ0xdDAqqw3CDoP0400YGaVnmRq";

//Colors.
const kPrimaryColor = Color(0xff213B6C);
const kSecondaryColor = Color.fromARGB(255, 24, 74, 166);
const kthColor = Color.fromARGB(255, 214, 222, 236);
const kTextColor = Color(0xff3c4046);
const kBackgroundColor = Color(0xfff9f8fd);
const kBNavBarColor = Color.fromARGB(255, 229, 226, 240);

//Others.
const double kDefaultPadding = 45.0;
const double kTextPadding = 15.0;
const double kTextLPadding = 148.0;
const double kSmallPadding = 15.0;

//Texts
WorkflowCreatedText(BuildContext context) {
  return Column(
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            const TextSpan(
              text: 'Created Workflows in Cosmos™\n\n',
              style: TextStyle(
                  fontSize: 18,
                  color: kDefaultIconDarkColor,
                  decoration: TextDecoration.none),
            ),
            TextSpan(
              text: 'Select an Workflow.\n',
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

/*Alert Box Styles Start...!*/

//Alert box Border shape
var kAlertBoxBorderStyle = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    side: const BorderSide(color: kPrimaryColor, width: 5));

//Alert box Button Styles
var kAlertBoxButtonStyle = TextButton.styleFrom(
  backgroundColor: kPrimaryColor,
  minimumSize: const Size(150.0, 46.0),
  shadowColor: Colors.black,
  alignment: Alignment.center,
  elevation: 10,
);

//Alert box Button Text Styles
const kAlertBoxButtonTextStyle = TextStyle(
  fontSize: 16,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

//Alert box Topic Text Styles
var kAlertBoxTopicTextStyle = TextStyle(
  fontSize: 22,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.3,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.1),
      offset: Offset(2, 2),
      blurRadius: 2,
    ),
  ],
);

/*Alert Box Styles End...!*/

//App Bar Styles

//Title Style
var kAppBarTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 2,
  wordSpacing: 1.5,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.5),
      offset: Offset(2, 2),
      blurRadius: 2,
    ),
  ],
);
