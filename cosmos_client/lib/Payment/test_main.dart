import 'package:cosmos_client/Payment/screens/payment_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

//import 'package:stripe_payment/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51Mgl36DXFk3tkknrlFJpMAUDiYHAlBEcaPKhSyLWUuROhV1LB0kxVIAyQFCpvYTlPoYbcDoDn5J4RuEDfT1byEWY00FoIUfjUh';

  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
