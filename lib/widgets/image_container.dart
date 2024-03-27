import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(112),
      width: getProportionateScreenWidth(112),
      child: Stack(
        children: [
          Container(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: kGreyShade5,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Container(
          //     padding: EdgeInsets.all(
          //       getProportionateScreenWidth(8),
          //     ),
          //     decoration: const ShapeDecoration(
          //       shape: CircleBorder(),
          //       color: kPrimaryBlue,
          //     ),
          //     child: Image.asset('assets/images/camera.png'),
          //   ),
          // )
        ],
      ),
    );
  }
}
