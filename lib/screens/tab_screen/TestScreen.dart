import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/assets/logo.dart';
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
          child: Transform.translate(
            offset: Offset(-80, 0),
            child: Transform.scale(
              scale: 0.5,
              child: CustomPaint(
                size: const Size(1600, 1600),
                painter: Logo(),
              ),
            ),
          ),
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

      Navigator.push(context, MaterialPageRoute(builder: (context) => const TabScreen(pageIndex: 0,)));
    });
  }
}
