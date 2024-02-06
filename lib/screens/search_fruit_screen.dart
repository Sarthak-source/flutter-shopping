import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/search_bar.dart' as s;
import '../widgets/tab_title.dart';

class SearchFruitScreen extends StatelessWidget {
  static const routeName = '/searchFruit';

  const SearchFruitScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8.0),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: s.SearchBar('fruits'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TabTitle(
                title: 'Suggestion Item',
                seeAll: () {},
                actionText: 'Clear',
              ),
              const SearchItem('Pear Packham'),
              const SearchItem('Golden Pear'),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                child: const Divider(),
              ),
              TabTitle(
                  title: 'Recent search', seeAll: () {}, actionText: 'Clear'),
              const SearchItem('Grapes'),
              const SearchItem('Lettuce'),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String text;

  const SearchItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(16.0),
        0,
        getProportionateScreenWidth(16.0),
        getProportionateScreenHeight(16.0),
      ),
      child: Row(
        children: [
          Container(
            width: getProportionateScreenWidth(48),
            height: getProportionateScreenWidth(48),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(8.0),
                ),
              ),
              color: kGreyShade5,
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(8),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}
