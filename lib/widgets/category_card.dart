import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          category.catIcon,
          fit: BoxFit.cover,
          height: 70,
        ),
        Text(category.catName)
      ],
    );
  }
}

class CategoryCardPlaceholder extends StatelessWidget {
  const CategoryCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 60,
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        SizedBox(height: 10,),
         Container(
          width: 120,
          height: 15,
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }
}
