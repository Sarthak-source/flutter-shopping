import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/screens/tab_screen/tab_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    navToHomepage();
  }
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.network("http://170.187.232.148/static/images/dilicia.png"),
        ),
      ),
    );
  }

  void navToHomepage() {
    _timer = Timer(const Duration(seconds: 3), () {

      /*   Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CheckInternet()),
          (route) => false, // This predicate removes all routes.
        );*/

      Navigator.push(context, MaterialPageRoute(builder: (context) => TabScreen()));

     
    });
  }
}