import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sutra_ecommerce/screens/home_screen/popular_deals.dart';
import 'package:sutra_ecommerce/screens/order_summary_screen.dart';
import 'package:sutra_ecommerce/widgets/custom_app_bar.dart';
import 'package:sutra_ecommerce/widgets/discount_text.dart';
import 'package:sutra_ecommerce/widgets/fruit_title.dart';
import 'package:sutra_ecommerce/widgets/loading_widgets/loader.dart';
import 'package:sutra_ecommerce/widgets/order_card.dart';
import 'package:sutra_ecommerce/widgets/tab_title.dart';

import '../../constants/colors.dart';
import '../../controllers/add_to_cart_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../utils/screen_utils.dart';

//arguments: ProductDetailArguments(phoneNumber: phoneNumberTyped)

class ProductDetailArguments {
  final Map<String, dynamic> productDetailData;

  ProductDetailArguments({required this.productDetailData});
}

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/productDetail';

  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController prodDetailController = Get.put(ProductDetailController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)?.settings.arguments as ProductDetailArguments;
    log("ProductDetailController ${args.productDetailData.toString()}");

    prodDetailController.fetchProductDetail( args.productDetailData['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProductDetailController>(
          //init: ProductDetailController(product: args.productDetailData['id'].toString()),
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(child: Loader());
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ProductBody(
                        product: controller.productDetail,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16.0),
                      vertical: getProportionateScreenHeight(5.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: getProportionateScreenWidth(32),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(OrderSummaryScreen.routeName);
                              },
                              icon: const Icon(Icons.shopping_cart_checkout),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(16),
                        ),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Buy Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  final dynamic product;
  const ProductBody({super.key, this.product});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  bool isExpanded = false;

  RxInt quantity = 0.obs;

  @override
  void initState() {
    super.initState();
    // Initialize quantity based on the arguments passed via ModalRoute

    if (widget.product["cart_count"] != null) {
      final double? parsedCount =
          double.tryParse(widget.product["cart_count"].toString());
      if (parsedCount != null) {
        quantity.value = parsedCount.toInt();
      }
    }
  }

    final AddToCartController addToCartController = Get.put(AddToCartController());


  @override
  Widget build(BuildContext context) {
    log("widget.product ${widget.product.toString()}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          title: '',
          marginBottom: 5,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.favorite_border_outlined,
                color: kPrimaryBlue,
                size: getProportionateScreenWidth(20),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(16),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        SizedBox(
          height: getProportionateScreenHeight(300),
          width: double.infinity,
          child: Image.network(
            widget.product?['product_img'] ??
                'http://170.187.232.148/media/products/Butter_MIlk_Loose.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DiscoutText(),
              SizedBox(
                height: getProportionateScreenHeight(14),
              ),
              Hero(
                  tag: 'productDetailName',
                  child: FruitTitle(title: widget.product?['name'])),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                children: [
                  Text(
                    "₹ ${widget.product?['price'].toString()}",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const Spacer(),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: kPrimaryBlue, // Set your desired border color
                        width: 1.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SizedBox(
                      height: 35,
                      width: quantity == 0
                          ? 75
                          : (quantity.toString().length * 11) + 75,
                      child: quantity == 0
                          ? OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kPrimaryBlue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set your desired border radius
                                ),
                              ),
                              onPressed: () {
                                //log('widget.mycartItem["product"]["name"] ${widget.mycartItem["product"]["name"].toString()}');
                                setState(() {
                                  quantity++;
                                  log(quantity.toString());
                                  addToCartController.productCount++;
                                  addToCartController.addToCart(
                                      quantity.value, widget.product?['id'], '1');

                                  addToCartController.update();
                                  //widget.onAddItem(quantity);
                                });
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                    color: kPrimaryBlue, fontSize: 14),
                              ),
                            )
                          : PlusMinusUI(
                              onPlusPressed: () {
                                setState(() {
                                  quantity++;
                                  addToCartController.productCount++;
                                  addToCartController.addToCart(
                                      quantity.value, widget.product?['id'], '1');

                                  addToCartController.update();

                                  //widget.onPlusinCard(quantity);
                                });
                              },
                              onMinusPressed: () {
                                if (quantity != 0) {
                                  setState(() {

                                    quantity.value--;

                                          addToCartController.productCount--;
                                          addToCartController.addToCart(
                                              quantity.value,
                                              widget.product?['id'],
                                              '1');

                                          addToCartController.update();

                                    //widget.onMinusinCard(quantity);
                                  });
                                }
                              },
                              qty: quantity.value,
                            ),
                      // :
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(8.0),
              ),
              if (!isExpanded)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(0.0),
                      vertical: getProportionateScreenHeight(2),
                    ),
                    child: const Text(
                      'Detail Items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextColorAccent,
                      ),
                    ),
                  ),
                ),
              if (isExpanded)
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        this.isExpanded = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: null,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text('Description'),
                          );
                        },
                        body: ListTile(
                          title: Text(
                            widget.product?['description'],
                            style: const TextStyle(
                              color: kTextColorAccent,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        isExpanded: isExpanded,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: getProportionateScreenHeight(20)),
              const TabTitle(
                title: 'More Like this',
                padding: 0,
              ),
              SizedBox(
                //  height: getProportionateScreenHeight(155),
                  child: PopularDealTab(
                    categoryId: widget.product?['category'].toString() ?? '',
                    isfrom: 'more',
                    //childAspectRatio: 0.72,
                  )),
              SizedBox(
                height: getProportionateScreenHeight(48),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailSelection extends StatelessWidget {
  final String text;
  final bool isSelected;

  const DetailSelection(this.text, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: isSelected
          ? ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(8.0),
                ),
              ),
              shadows: const [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  )
                ])
          : null,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PreviousPriceTag extends StatelessWidget {
  const PreviousPriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Divider2.png'),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(8),
        ),
        decoration: ShapeDecoration(
          color: kFailColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8.0),
            ),
          ),
        ),
        child: const Text(
          '\$126',
          style: TextStyle(
            color: kFailColor,
          ),
        ),
      ),
    );
  }
}
