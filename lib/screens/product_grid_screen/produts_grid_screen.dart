import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/products_controller.dart';
import 'package:sutra_ecommerce/utils/error.dart';
import 'package:sutra_ecommerce/widgets/go_cart/go_to_cart.dart';
import 'package:sutra_ecommerce/widgets/product_card/product_card.dart';
import 'package:sutra_ecommerce/widgets/search_bar.dart' as search;

import '../../utils/screen_utils.dart';
import '../../widgets/custom_app_bar.dart';

class PoductsListArguments {
  final String title;
  final String categoryId;
  final double? childAspectRatio;

  PoductsListArguments(
      {required this.title, required this.categoryId, this.childAspectRatio});
}

class PoductsListScreen extends StatefulWidget {
  static const routeName = '/products_list_screen';

  const PoductsListScreen({super.key});

  @override
  PoductsListScreenState createState() => PoductsListScreenState();
}

class PoductsListScreenState extends State<PoductsListScreen> {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    var args =
        ModalRoute.of(context)?.settings.arguments as PoductsListArguments?;
    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
        //backgroundColor: kPrimaryBlueTest2,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  !isSearch
                      ? CustomAppBar(
                          title: args != null && args.title != null
                              ? args.title
                              : "Popular Deals",
                          actions: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSearch = true;
                                });
                              },
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(16),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 10),
                          child: search.SearchBar(
                            hint: 'search product',
                            controller: searchController,
                          ),
                        ),

                  //SizedBox(width: Get.width/4,child: Text('data')),
                  Expanded(
                    child: CustomStaggerGrid(
                      addCallback: () {
                        // setState(() {
                        //   isAdded = true;
                        // });
                      },
                      categoryId: args != null && args.categoryId != null
                          ? args.categoryId
                          : "",
                    ),
                  ),
                  (addToCartController.productCount.value > 0)
                      ? const SizedBox(
                          height: 70,
                        )
                      : const SizedBox(
                          height: 0,
                        )
                ],
              ),
            ),
          ],
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomSheet: (addToCartController.productCount > 0)
            ? const GoToCart(
                usedIn: 'PoductsListScreen',
              )
            : const SizedBox.shrink(),
      );
    });
  }
}

class CustomStaggerGrid extends StatefulWidget {
  final Function()? addCallback;
  final String? categoryId;
  final double? childAspectRatio;

  const CustomStaggerGrid(
      {this.addCallback, this.categoryId, super.key, this.childAspectRatio});

  @override
  State<CustomStaggerGrid> createState() => _CustomStaggerGridState();
}

class _CustomStaggerGridState extends State<CustomStaggerGrid> {
  int selectedIndex = -1;

  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController(
      categoryId: widget.categoryId ?? '',
    ));

    return Obx(() {
      if (controller.isLoading.value && controller.products.isEmpty) {
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
                    mainAxisSpacing: getProportionateScreenHeight(8),
                    childAspectRatio: widget.childAspectRatio ??
                        (Get.width / Get.height) * 1.70),
              ),
            ),
          ),
        );
      } else if (controller.hasError.value) {
        // If there's an error, display it to the user
        return const Center(child: ErrorHandleWidget());
      } else {
        // If the Future is complete with data, display the GridView
        List products = controller.products;

        if (products.isEmpty || widget.categoryId == "") {
          return Column(
            children: [
              Lottie.asset('assets/lotties/no-data.json',
                  repeat: false,
                  height: getProportionateScreenHeight(250.0),
                  width: getProportionateScreenWidth(250.0)),
              SizedBox(height: getProportionateScreenHeight(10.0)),
              const Text(
                'No products found',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        } else {
          //return Text(controller.products.toString());
          return GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(8),
                mainAxisSpacing: getProportionateScreenHeight(8),
                childAspectRatio:
                    widget.childAspectRatio ?? (Get.width / Get.height) * 1.80),
            itemBuilder: (ctx, index) {
              if (index % 2 != 0) {
                return ProductCard(
                  isLeft: false,
                  product: products[index],
                  loader: index == selectedIndex
                      ? addToCartController.isLoading.value
                      : false,
                  onCardAddClicked: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  onCardMinusClicked: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              } else if (index == 0) {
                return ProductCard(
                  isLeft: true,
                  addHandler: widget.addCallback,
                  loader: index == selectedIndex
                      ? addToCartController.isLoading.value
                      : false,
                  product: products[index],
                  onCardAddClicked: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  onCardMinusClicked: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              }
              return ProductCard(
                isLeft: true,
                product: products[index],
                loader: index == selectedIndex
                    ? addToCartController.isLoading.value
                    : false,
                onCardAddClicked: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                onCardMinusClicked: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            },
          );
        }
      }
    });
  }
}

class ProductCardPlaceholder extends StatelessWidget {
  final String? isFrom;
  const ProductCardPlaceholder({super.key, this.isFrom});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: isFrom == "homepop" ? 5 : 10,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
