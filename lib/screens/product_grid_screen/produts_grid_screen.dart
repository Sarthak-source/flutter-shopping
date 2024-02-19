import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/products_controller.dart';

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
  static const routeName = '/products_list_screen';

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
                  actions: [
                    const Icon(
                      Icons.search,
                      color: kPrimaryBlue,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(16),
                    ),
                  ],
                ),

                //SizedBox(width: Get.width/4,child: Text('data')),
                CustomStaggerGrid(
                  addCallback: () {
                    setState(() {
                      isAdded = true;
                    });
                  },
                  categoryId: args.categoryId,
                ),
              ],
            ),
          ),
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

class CustomStaggerGrid extends StatelessWidget {
  final Function()? addCallback;
  final int? categoryId;

  const CustomStaggerGrid({
    this.addCallback,
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController(
      categoryId: categoryId!,
    ));

    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
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
                      padding: EdgeInsets.only(left: 16, bottom: 8),
                      child: ProductCardPlaceholder(),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: getProportionateScreenWidth(8),
                    mainAxisSpacing: getProportionateScreenHeight(5),
                    childAspectRatio: 0.89,
                  ),
                ),
              ),
            ),
          );
        } else if (controller.hasError.value) {
          // If there's an error, display it to the user
          return Center(child: Text('Error: ${controller.errorMsg.value}'));
        } else {
          // If the Future is complete with data, display the GridView
          List products = controller.products;

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
                  addHandler: addCallback,
                  product: products[index],
                );
              }
              return ProductCard(
                isLeft: true,
                product: products[index],
              );
            },
          );
        }
      }),
    );
  }
}

class ProductCardPlaceholder extends StatelessWidget {
  const ProductCardPlaceholder({Key? key}) : super(key: key);

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
