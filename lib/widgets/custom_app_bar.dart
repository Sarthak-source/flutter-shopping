import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const CustomAppBar({required this.title, required this.actions, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:12.0 ,left: 12.0, bottom: 30.0,top: 16),
      child: Row(
        children: [
          const Expanded(child: BackButtonText()),
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ),
        ],
      ),
    );
  }
}
