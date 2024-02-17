import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/product_card/product_card.dart';

class PoductsListArguments {
  final String title;
  final int categoryId;

  PoductsListArguments({required this.title, required this.categoryId});
}

class PoductsListScreen extends StatefulWidget {
  static const routeName = '/poducts_list_screen';

  const PoductsListScreen({super.key});

  @override
  PoductsListScreenState createState() => PoductsListScreenState();
}

class PoductsListScreenState extends State<PoductsListScreen> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    var args =
        ModalRoute.of(context)?.settings.arguments as PoductsListArguments;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                 title: args.title,
             actions:     [
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
                }, args.categoryId),
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
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
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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

class CustomStaggerGrid extends StatefulWidget {
  final Function()? addCallback;
  final int categoryId;

  const CustomStaggerGrid(this.addCallback, this.categoryId, {Key? key})
      : super(key: key);

  @override
  State<CustomStaggerGrid> createState() => _CustomStaggerGridState();
}

class _CustomStaggerGridState extends State<CustomStaggerGrid> {
  late Future<dynamic> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = NetworkRepository.getProducts(
      category: widget.categoryId.toString(),
      status: 'Active',
      search: '',
      partyId: '1',
      page: '1',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: SizedBox(
                  height: 100,
                  child: GridView.builder(
                    clipBehavior: Clip.none,
                    itemCount: 10, // Use a placeholder count
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child:
                            ProductCardPlaceholder(), // Create a placeholder widget
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getProportionateScreenWidth(8),
                      mainAxisSpacing: getProportionateScreenHeight(5),
                      childAspectRatio: 0.81,
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // If there's an error, display it to the user
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // If the Future is complete with data, display the GridView
            List products = snapshot.data['body']['results'];

            log(products.toString());

            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(8),
                mainAxisSpacing: getProportionateScreenHeight(5),
                childAspectRatio: 0.81,
              ),
              itemBuilder: (ctx, index) {
                if (index % 2 != 0) {
                  return ProductCard(
                    isLeft: false,
                    product: products[index],
                  );
                } else if (index == 0) {
                  return ProductCard(
                    isLeft: true,
                    addHandler: widget.addCallback,
                    product: products[index],
                  );
                }
                return ProductCard(
                  isLeft: true,
                  product: products[index],
                );
              },

              // Replace YourProductCardWidget with the actual widget you want to use for displaying products
            );
          }
        },
      ),
    );
  }
}

class ProductCardPlaceholder extends StatelessWidget {
  const ProductCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      height: 10,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
