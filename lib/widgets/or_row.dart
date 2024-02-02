import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class OrRow extends StatelessWidget {
  const OrRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              const Divider(),
              SizedBox(
                height: getProportionateScreenHeight(8),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
          ),
          child: Text(
            'OR',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: kTextColorAccent),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              const Divider(),
              SizedBox(
                height: getProportionateScreenHeight(8),
              )
            ],
          ),
        ),
      ],
    );
  }
}
