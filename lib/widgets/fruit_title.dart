import 'package:flutter/material.dart';

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
            "${_title[0].toUpperCase()}${_title.substring(1, _title.length).toLowerCase()}",
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
