import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final String from;

  const CategoryCard({required this.category, required this.from,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          category.catIcon?? 
          'http://170.187.232.148/static/images/dilicia.png',
          fit: BoxFit.fill,
          height: from == "allcategories"?getProportionateScreenHeight(80):getProportionateScreenHeight(40),
        ),
        from == "allcategories"? const Spacer() : const SizedBox.shrink(),
        Container(
          width: from == "allcategories"?80:65,
          height: 35,
        //  color: Colors.red.shade100,
          child: Center(
            child: Text(
              "${category.catName[0].toUpperCase()}${category.catName.substring(1,category.catName.length).toLowerCase()}",
              style:  TextStyle(fontSize: from == "allcategories"?14:10,fontWeight: FontWeight.w600,),maxLines: 1,
              textAlign: TextAlign.center,
            ),
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
