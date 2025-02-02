import 'package:flutter/material.dart';

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
        vertical: 2,
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
              style: const TextStyle(
                  fontSize: 13,fontWeight: FontWeight.bold,
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: seeAll,
                child: Text(
                  actionText,
                  style: const TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
