
import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
       // color: Color.fromRGBO(216, 244, 108, 1.0),
        color: kPrimaryBlue,
      ),
    );
  }
}
