import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/indi_deal_card.dart';

class PopularDealsScreen extends StatefulWidget {
  static const routeName = '/popular_deals';

  const PopularDealsScreen({super.key});

  @override
  PopularDealsScreenState createState() => PopularDealsScreenState();
}

class PopularDealsScreenState extends State<PopularDealsScreen> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  'Popular Deals',
                  [
                    const Icon(
                      Icons.search,
                      color: kPrimaryBlue,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(16),
                    ),
                  ],
                ),
                CustomStaggerGrid(() {
                  setState(() {
                    isAdded = true;
                  });
                }),
              ],
            ),
          ),
          if (isAdded)
            Positioned(
              bottom: getProportionateScreenHeight(40),
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                height: getProportionateScreenHeight(80),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(8.0),
                    ),
                  ),
                  color: kPrimaryBlue,
                  shadows: [
                    BoxShadow(
                      color: kShadowColor,
                      offset: Offset(
                        getProportionateScreenWidth(24),
                        getProportionateScreenWidth(40),
                      ),
                      blurRadius: 80,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '5 items',
                            style:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          Flexible(
                            child: Text(
                              'Dragon Fruits, Oranges, Apples, Dragon Fruits, Oranges, Apples, ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text(
                      '\$240',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !isAdded
          ? RawMaterialButton(
              fillColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 10.0,
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(8.0),
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sort),
                    Text(
                      'Sort & Filter',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}

class CustomStaggerGrid extends StatelessWidget {
  final Function()? addCallback;

  const CustomStaggerGrid(this.addCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 10,
          crossAxisSpacing: getProportionateScreenWidth(8),
          mainAxisSpacing: getProportionateScreenHeight(8),
          itemBuilder: (ctx, index) {
            if (index % 2 != 0) {
              return const IndiDealCard(
                isLeft: false,
              );
            } else if (index == 0) {
              return IndiDealCard(
                isLeft: true,
                addHandler: addCallback,
              );
            }
            return const IndiDealCard(
              isLeft: true,
            );
          },
          staggeredTileBuilder: (index) {
            if (index == 0 || index == 2 || index == 3) {
              return const StaggeredTile.count(1, 1.3);
            }
            return const StaggeredTile.count(1, 2);
          }),
    );
  }
}
