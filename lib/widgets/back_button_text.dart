import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

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
            color: Colors.black,
          ),
          Text(
            'Back',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(14),
                ),
          ),
        ],
      ),
    );
  }
}
