import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/my_order_controller.dart';
import '../../controllers/popular_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/product_card/product_card.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final CommonController cmncontroller = Get.put(CommonController());
  final MyOrderController myOrderController = Get.put(MyOrderController());

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    print('ck initste');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myOrderController.selectedBtn.value = 1;
      myOrderController.myOrderList.clear();
      myOrderController.update();
      myOrderController.getMyOrders("Approved", "1");
      myOrderController.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    final PopularDealController controller =
        Get.put(PopularDealController(categoryId: ""));

    return Obx(() {
      final popularDeals = controller.popularDeals;
      controller.update();
      return Container(
        color: Colors.grey.shade300,
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //  children: [Container()],
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'My Recent Orders',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(
                              20,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myOrderController.myOrderList.isEmpty
                      ? const SizedBox.shrink()
                      :
                      /*  TabTitle(
                      title: "Recent Orders",
                      seeAll: () {
                        // Get.toNamed(CategoryScreen.routeName);
                      }),*/
                      titleCard("Recent Orders"),
                  const SizedBox(height: 14),
                  myOrderController.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: SizedBox(
                            height: 300, // Set the height of the ListView
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10, // Placeholder count
                              itemBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 16, bottom: 8),
                                  child:
                                      ReOrderCardPlaceholder(), // Replace with your placeholder widget
                                );
                              },
                            ),
                          ),
                        )
                      : myOrderController.myOrderList.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              height: 300,
                              width: Get.width,
                              color: Colors.grey.shade300,
                              child: ListView.builder(
                                  itemCount:
                                      myOrderController.myOrderList.length,
                                  //  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors
                                                      .grey, // Border color
                                                  width: 1.0, // Border width
                                                ),
                                                color: kPrimaryBoxBG,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                ),
                                                itemCount: myOrderController
                                                    .myOrderList[index]
                                                        ["order_items"]
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int indexx) {
                                                  return indexx == 3
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  // border: Border.all(color: Colors.grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                  // myOrderController.myOrderList[index]["order_items"].length
                                                                  child: Text(
                                                                    setOrdersNum(
                                                                        myOrderController
                                                                            .myOrderList[index]["order_items"]
                                                                            .length,
                                                                        index),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                      : Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          // color: Colors.blue[100 * (index % 9)],
                                                          //  color: Colors.blue[100 * (1 % 9)],

                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  // border: Border.all(color: Colors.grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Image.network(myOrderController.myOrderList[index]["order_items"][indexx]
                                                                            [
                                                                            "product"]
                                                                        [
                                                                        "product_img"] ??
                                                                    'http://170.187.232.148/static/images/dilicia.png'),
                                                              ),
                                                            ),
                                                          ));
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // height: 110,
                                            width: 205,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "${myOrderController.myOrderList[index]["order_items"].length} Products",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4))),
                                                      Text(
                                                        convertTimestampToDateString2(
                                                            myOrderController
                                                                .myOrderList[
                                                                    index][
                                                                    "order_date"]
                                                                .toString()),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // <-- Radius
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          print(
                                                              'orderId:: ${myOrderController.myOrderList[index]["id"]}');
                                                          myOrderController.reOrderApi(
                                                              myOrderController
                                                                  .myOrderList[
                                                                      index]
                                                                      ["id"]
                                                                  .toString());
                                                        },
                                                        child: const Text(
                                                          'Reorder',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                  const SizedBox(height: 14),
                  titleCard("Recent Ordered Products"),
                  const SizedBox(height: 14),
                  Container(
                      // height: 500,
                      width: Get.width,
                      color: Colors.grey.shade300,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: popularDeals.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: getProportionateScreenWidth(8),
                            mainAxisSpacing: getProportionateScreenHeight(8),
                            childAspectRatio: (Get.width / Get.height) * 1.80),
                        itemBuilder: (ctx, index) {
                          if (index % 2 != 0) {
                            return ProductCard(
                              isLeft: false,
                              product: popularDeals[index],
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
                              addHandler: () {},
                              product: popularDeals[index],
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
                            product: popularDeals[index],
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
                      )),
                  Visibility(
                    visible: false,
                    child: Column(children: [
                      const SizedBox(
                        height: 18,
                      ),
                      const Row(
                        children: [
                          // const Icon(
                          //   Icons.search,
                          //   color: kPrimaryBlue,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16.0),
                      ),
                      Lottie.asset('assets/lotties/cart.json',
                          repeat: false,
                          height: getProportionateScreenHeight(250.0),
                          width: getProportionateScreenWidth(250.0)),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      Text(
                        'Oops Your Wishlist Is Empty',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16.0),
                      ),
                      Text(
                        'It seems noting in here. Explore more and shortlist some items',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: kTextColorAccent,
                            ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16.0),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       cmncontroller.commonCurTab.value = 0;
                      //       cmncontroller.update();
                      //     },
                      //     child: const Text(
                      //       'Start Shopping',
                      //     ),
                      //   ),
                      SizedBox(
                        height: getProportionateScreenHeight(200),
                      ),
                    ]),
                  ),
                ],
              ),
            )),
      );
    });
  }

  Padding titleCard(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  setOrdersNum(length, int index) {
    print('length of order items $length');
    if (length > 3) {
      int l = length - 3;
      return "+${l.toString()}";
    } else {
      print('length of order index $index');
      return "";
    }
  }
}

class ReOrderCardPlaceholder extends StatelessWidget {
  final String? isFrom;
  const ReOrderCardPlaceholder({super.key, this.isFrom});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width / 2,
          height: 200,
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: Get.width / 2,
          height: 30,
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
