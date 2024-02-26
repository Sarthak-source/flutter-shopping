import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/constants/colors.dart';

import '../utils/screen_utils.dart';

class TabTitle extends StatelessWidget {
  final String? title;
  final String actionText;
  final Function()? seeAll;
  final double padding;

  const TabTitle(
      {super.key,
      this.title,
      this.seeAll,
      this.actionText = 'See All',
      this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: getProportionateScreenWidth(
          padding,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            //flex: 4,
            child: Text(
              title!,
              style: TextStyle(
                  fontSize: 11,fontWeight: FontWeight.bold,
              )
            ),
          ),
          Container(
          //  color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: seeAll,
                  child: Text(
                    actionText,
                    style: const TextStyle(fontSize: 8,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
