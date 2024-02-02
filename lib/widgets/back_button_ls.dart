import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class BackButtonLS extends StatelessWidget {
  const BackButtonLS({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      constraints: BoxConstraints.tightFor(
        width: getProportionateScreenWidth(32),
        height: getProportionateScreenHeight(40),
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        color: kPrimaryBlue,
      ),
    );
  }
}
