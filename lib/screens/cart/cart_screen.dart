import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/pendingPayment.dart';
import 'package:sutra_ecommerce/screens/select_time/select_time.dart';

import '../../config/common.dart';
import '../../controllers/add_to_cart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/order_card.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cartscreen';
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController quantityCtrlr = TextEditingController();

  final MyCartController controller = Get.put(MyCartController());
  final PaymentController payCtrlr = Get.put(PaymentController());
  final AddToCartController addToCartController =
      Get.put(AddToCartController());

  String? isOrderLock = "";
  Map? storedUserData;
  //AddToCartController addToCartController = AddToCartController();
  @override
  void initState() {
    super.initState();
     storedUserData=box?.get('userData');
    print('userdata in pending payment ${ storedUserData?['party']['order_lock'].toString() }');
    isOrderLock =storedUserData?['party']['order_lock']!=null?storedUserData!['party']['order_lock'].toString():"";
    print('userdata in order_lock ${ isOrderLock.toString() }');

  }
  @override
  Widget build(BuildContext context) {
    /*   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setPDCount(controller.mycartItems,addToCartController);
    });*/

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MyCartController>(builder: (controller) {
          return Obx(
            () => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Text(
                          'My Cart',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenWidth(
                                  20,
                                ),
                              ),
                        ),
                        const Spacer(),
                        // const Icon(
                        //   Icons.search,
                        //   color: kPrimaryBlue,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(16.0),
                    ),
                    Obx(
                      () => Expanded(
                        child: SingleChildScrollView(
                          child: controller.mycartItems.isEmpty
                              ? Container(
                                  height: Get.height / 2 + 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(16.0),
                                      ),
                                      Lottie.asset('assets/lotties/cart.json',
                                          repeat: false,
                                          frameRate: FrameRate(30),
                                          height: getProportionateScreenHeight(
                                              250.0),
                                          width: getProportionateScreenWidth(
                                              250.0)),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10.0),
                                      ),
                                      Text(
                                        'Oops! your cart is empty',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.mycartItems.length,
                                  itemBuilder: (context, index) {
                                    setPDCount(controller.mycartItems,
                                        addToCartController);
                                    return OrderCard(
                                      onChangeQty: (n) {
                                        addToCartController.updateCart(
                                            n,
                                            controller.mycartItems[index]["id"],
                                            "update",
                                            "1");
                                      },
                                      onPlusinCard: (n) {
                                        print('add qty $n');

                                        addToCartController.updateCart(
                                            n,
                                            controller.mycartItems[index]["id"],
                                            "update",
                                            "1");
                                      },
                                      onMinusinCard: (n) {
                                        if (n == 0 ||
                                            n <
                                                int.parse(convertDoubleToString(
                                                    controller.mycartItems[
                                                                    index]
                                                                ["product"]
                                                            ['min_order_qty'] ??
                                                        "0.0"))) {
                                          addToCartController.updateCart(
                                              n,
                                              controller.mycartItems[index]
                                                  ["id"],
                                              "delete",
                                              "1");
                                        } else {
                                          print('remove qty $n');
                                          addToCartController.updateCart(
                                              n,
                                              controller.mycartItems[index]
                                                  ["id"],
                                              "update",
                                              "1");
                                        }
                                      },
                                      onAddItem: (n) {
                                        log('add qty $n');
                                        addToCartController.updateCart(
                                            n,
                                            controller.mycartItems[index]["id"],
                                            "update",
                                            "1");
                                      },
                                      onDeleteItem: (n) {
                                        log('delete qty $n');
                                        addToCartController.updateCart(
                                            n,
                                            controller.mycartItems[index]["id"],
                                            "delete",
                                            "1");
                                      },
                                      mycartItem: controller.mycartItems[index],
                                    );
                                  }),
                        ),
                      ),
                    ),
                    controller.mycartItems.isEmpty
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RateCardinBuyNow(context, "Total Basic Amt",
                                        controller.mycartTotalValue.value),
                                    RateCardinBuyNow(context, "Total Gst",
                                        controller.mycartTotalGst.value),
                                    /* Text(
                                      controller.mycartTotalGst.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Colors.grey, fontSize: 14),
                                    ),*/
                                    Text(
                                      "₹ ${twodecimalDigit(double.parse(controller.mycartTotalAmount.value ?? "0.000"))}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Transform.translate(
                                  offset: const Offset(0, 20),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const StadiumBorder(),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(
                                          getProportionateScreenWidth(
                                              1), // Width
                                          44, // Height
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                    //  Navigator.of(context).pushNamed(AddAddressScreen.routeName);
                                     // Get.toNamed(SelectTime.routeName);

                                  /*   if(isOrderLock=="Yes"){
                                       payCtrlr.fetchPendingPayment();
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => PendingPayment()));
                                     }else{
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTime(
                                         totalamount: twodecimalDigit(double.parse(controller.mycartTotalAmount.value ?? "0.000")) ?? "",
                                       )));
                                     }*/
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTime(
                                        totalamount: twodecimalDigit(double.parse(controller.mycartTotalAmount.value ?? "0.000")) ?? "",
                                      )));

                                    },
                                    child: const Text(
                                      'Buy Now',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(24.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Row RateCardinBuyNow(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.grey, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            " : ₹ ${twodecimalDigit(double.parse(value == null ? "0.000" : value.toString()))}",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    );
  }

  void setPDCount(RxList mycartItems, AddToCartController addToCartController) {
    print('mycartItems length ${mycartItems.length}');
    if (mycartItems.isEmpty) {
      addToCartController.productCount.value = 0;
      addToCartController.update();
    }
  }
}
