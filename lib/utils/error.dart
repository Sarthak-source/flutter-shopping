import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorHandleWidget extends StatelessWidget {
  const ErrorHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Lottie.asset('assets/lotties/error.json')),
    );
  }
}
