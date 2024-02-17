import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/item.dart';
import '../utils/screen_utils.dart';

class FruitTitle extends StatelessWidget {
  const FruitTitle({
    Key? key,
    String title='',
  })  : _title = title,
        super(key: key);

  final String _title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Provider.of<Items>(context, listen: false).addToFavorite(
              Item(
                name: 'Dragon Fruit',
                discountPrice: '45',
                originalPrice: '90',
                mass: '200gr',
              ),
            );
          },
          child: Icon(
            Icons.favorite_border_outlined,
            color: kPrimaryBlue,
            size: getProportionateScreenWidth(32),
          ),
        )
      ],
    );
  }
}
