import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function()? navBack;
  final List<Widget> actions;
  final double? marginBottom;
  const CustomAppBar(
      {required this.title,
      required this.actions,
       this.navBack,
      this.marginBottom = 30.0,
      super.key});
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(
          right: 12.0, left: 12.0, bottom: marginBottom!, top: 16),
      child: Row(
        children: [
           Expanded(child: BackButtonText(navBack: navBack,)),
          Text(
          title,
          //titleCase(title),
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ),
        ],
      ),
    );
  }
}
