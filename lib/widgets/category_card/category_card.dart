import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../models/category.dart';
import '../../utils/api_constants.dart';

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
          category.catIcon== null || ApiAppConstants.apiEndPoint=="http://192.168.1.23:8000/api/" ?
          'http://170.187.232.148/static/images/dilicia.png':category.catIcon??"",
          fit: BoxFit.fill,
          height: from == "allcategories"?getProportionateScreenHeight(80):getProportionateScreenHeight(45),
        ),
        from == "allcategories"? const Spacer() : const SizedBox.shrink(),
        Container(
          width: from == "allcategories"?80:65,
          height: 35,
        //  color: Colors.red.shade100,
          child: Center(
            child: Text(
              "${category.catName[0].toUpperCase()}${category.catName.substring(1,category.catName.length).toLowerCase()}",
              style:  TextStyle(fontSize: from == "allcategories"?14:11,fontWeight: FontWeight.w600,),maxLines: 2,
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
          width: 80,
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
          width: 80,
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
