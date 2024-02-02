import 'package:flutter/material.dart';

import '../constants/colors.dart';

class BackButtonText extends StatelessWidget {
  const BackButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryBlue,
          ),
          Text(
            'Back',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: kPrimaryBlue,
                ),
          ),
        ],
      ),
    );
  }
}
