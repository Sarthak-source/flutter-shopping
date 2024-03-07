import 'package:flutter/material.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';

class FruitTitle extends StatelessWidget {
  const FruitTitle({
    Key? key,
    String title = '',
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
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        
      ],
    );
  }
}
