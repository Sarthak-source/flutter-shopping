import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderShimmer extends StatelessWidget {
  final String from;
  const MyOrderShimmer({super.key, required this.from});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: from == "orderdetail" ? 100 : 300,

            width: from == "orderdetail" ?300:Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Transform.scale(
          //       scale: 0.2,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white
          //               .withOpacity(0.5),
          //           borderRadius: BorderRadius.circular(45),
          //         ),
          //         child: CustomPaint(
          //           size: const Size(90, 90),
          //           painter: Logo(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
