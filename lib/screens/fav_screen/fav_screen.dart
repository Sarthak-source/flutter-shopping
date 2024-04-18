import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/my_order_controller.dart';
import '../../controllers/popular_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/loading_widgets/loader.dart';
import '../../widgets/product_card/product_card.dart';
import '../../widgets/tab_title.dart';
import '../product_grid_screen/produts_grid_screen.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myOrderController.selectedBtn.value = 1;
      myOrderController.myOrderList.clear();
      myOrderController.getMyOrders("Approved","1");
      myOrderController.update();
    });

}
  @override
  Widget build(BuildContext context) {

    final PopularDealController controller = Get.put(PopularDealController(categoryId:""));

    return Obx(() {
      final popularDeals = controller.popularDeals;
      controller.update();
     return  Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  children: [Container()],
              children: [
                SizedBox(height: 20,),
                Text(
                  'My Favourites',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(
                      20,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TabTitle(
                    title: "Recent Orders",
                    seeAll: () {
                      // Get.toNamed(CategoryScreen.routeName);
                    }),

                myOrderController.isLoading.value?Center(child: Loader()):Container(
                  height: 365,
                  width: Get.width,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: myOrderController.myOrderList.length,
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
                                    color: kPrimaryBoxBG,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: myOrderController
                                        .myOrderList[index]["order_items"]
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int indexx) {
                                      return
                                        indexx == 3 ? Container(
                                            margin: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius
                                                    .circular(12)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Center(
                                                    // myOrderController.myOrderList[index]["order_items"].length
                                                    child: Text(setOrdersNum(
                                                        myOrderController
                                                            .myOrderList[index]["order_items"]
                                                            .length, index),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                  ),
                                                ),
                                              ),
                                            )) :
                                        Container(
                                            margin: const EdgeInsets.all(4.0),
                                            // color: Colors.blue[100 * (index % 9)],
                                            //  color: Colors.blue[100 * (1 % 9)],

                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius
                                                    .circular(12)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Image.network(
                                                      'http://170.187.232.148/static/images/dilicia.png'),
                                                ),
                                              ),
                                            ));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                width: 205,

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(height: 12,),
                                      Text(convertTimestampToDateString(
                                          myOrderController
                                              .myOrderList[index]["order_date"]
                                              .toString()), style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),),
                                      SizedBox(height: 8,),
                                      Text("${ myOrderController
                                          .myOrderList[index]["order_items"]
                                          .length} products", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey)),
                                      //SizedBox(height: 18,),
                                      Container(
                                        height: 49,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    8), // <-- Radius
                                              ),
                                            ),
                                            onPressed: () {
                                              print(
                                                  'orderId:: ${myOrderController
                                                      .myOrderList[index]["id"]}');
                                              myOrderController.reOrderApi(
                                                  myOrderController
                                                      .myOrderList[index]["id"]
                                                      .toString());
                                            },
                                            child: const Text(
                                              'Reorder',
                                              style: TextStyle(fontSize: 14),
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


                Container(
                   // height: 500,
                    width: Get.width,
                    color: Colors.white,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                        }
                        else if (index == 0) {
                          return ProductCard(
                            isLeft: true,
                            addHandler: (){},
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
                    )
                ),
                 Column(children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
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
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                  Text(
                    'It seems noting in here. Explore more and shortlist some items',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
              ],
            ),
          ));
    }
    );
  }

   setOrdersNum(length, int index) {
     print('length of order items $length');
    if(length > 3){
      int l = length- 3;
      return "+${l.toString()}";
    }else{
      print('length of order index $index');
      return "";
    }
  }
}
