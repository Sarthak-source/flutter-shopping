
import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(

         // color: Color.fromRGBO(216, 244, 108, 1.0),
          color: kPrimaryBlue,
        ),
      ),
    );
  }
}
