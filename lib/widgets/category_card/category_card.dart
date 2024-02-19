import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          category.catIcon ??
              'http://170.187.232.148/static/images/dilicia.png',
          fit: BoxFit.fill,
          height: getProportionateScreenHeight(80),
        ),
        const Spacer(),
        SizedBox(
          width: 80,
          height: 40,
          child: Text(
            "${category.catName[0].toUpperCase()}${category.catName.substring(1,category.catName.length).toLowerCase()}",
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
          ),
        )
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
