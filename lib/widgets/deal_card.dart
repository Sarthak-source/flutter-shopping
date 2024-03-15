import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class DealCard extends StatelessWidget {
  final bool isHorizontalScrolling;
  final Function()? onTap;
  final String image;
 final String? heading;

  const DealCard(
      {super.key,
      this.onTap,
      this.heading,
      this.isHorizontalScrolling = true,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        alignment: Alignment.bottomLeft,
        width: getProportionateScreenWidth(280),
        height: getProportionateScreenHeight(170),
        margin: EdgeInsets.only(
          left: isHorizontalScrolling
              ? getProportionateScreenWidth(5)
              : getProportionateScreenWidth(0),
          bottom: !isHorizontalScrolling
              ? getProportionateScreenHeight(32)
              : getProportionateScreenHeight(0),
        ),
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: NetworkImage(image), // Use NetworkImage for network images
            fit: BoxFit.cover, // Adjust the fit as per your requirement
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(
                8,
              ),
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              kGradientColor,
              kGradientColor.withOpacity(0),
            ],
          ),
                 ),
        child: Padding(
          padding: EdgeInsets.all(
            getProportionateScreenWidth(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShadowText(
                data:  "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              
              //  const ShadowText(
              //    data: 'Fresh fruit Everyday we Serve to You',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              
            ],
          ),
        ),
      ),
    );
  }
}



class ShadowText extends StatelessWidget {
  const ShadowText({super.key, required this.data, required this.style }) ;

  final String data;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child:  Stack(
        children: [
           Positioned(
            top: 2.0,
            left: 2.0,
            child:  Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.9)),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Text(data, style: style),
          ),
        ],
      ),
    );
  }
}