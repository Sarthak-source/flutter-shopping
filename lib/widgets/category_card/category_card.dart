import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          category.catIcon ??
              'https://lh3.googleusercontent.com/proxy/Fyl2sy3ZfOCgOe5TCR3vpRukvfNrt2SJ83bm-JbEFY9J01WZm_Fpadqt9jssg85zbH6KTwGw71gdENHTkB0UwTgK1Lah0g',
          fit: BoxFit.fill,
          height: 100,
        ),
        const SizedBox(height: 10,),
        Text(category.catName, )
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
        const SizedBox(
          height: 10,
        ),
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
