import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class NoData extends StatelessWidget {
  String? noDataText;
  String? lottieJson;
  double? height;
  NoData({
    Key? key,
    this.noDataText,
    this.lottieJson,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/json/nodata.json', height: 200),
          Text(
            'No Data Found'.toString(),
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
