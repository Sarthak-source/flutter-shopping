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
          category.catIcon?? 
          'https://scontent.fblr1-5.fna.fbcdn.net/v/t39.30808-1/298706965_3196362227304296_6589172397550841826_n.jpg?stp=cp0_dst-jpg_e15_p480x480_q65&_nc_cat=111&ccb=1-7&_nc_sid=4da83f&_nc_ohc=dCOYq0UOKxYAX-yFdLy&_nc_ht=scontent.fblr1-5.fna&oh=00_AfBVv9CbsdmMab3Hut_MqaSscKgIMQK4Ze9ESUx56F1-YA&oe=65D5F373',
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
