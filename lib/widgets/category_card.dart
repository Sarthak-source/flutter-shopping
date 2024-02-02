import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/screen_utils.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard(
    this.category, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: getProportionateScreenWidth(24),
          backgroundColor: category.color,
          child: SizedBox(
            width: getProportionateScreenWidth(28),
            child: Image.asset(
              category.catIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(category.catName)
      ],
    );
  }
}
