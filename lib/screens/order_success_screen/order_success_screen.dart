import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../myorder_detail2.dart';
import '../tab_screen/tab_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  static const routeName = '/orderSuccess';

  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  final MyCartController controller = Get.put(MyCartController());
  final AddToCartController AtCcontroller = Get.put(AddToCartController());

  double totalamt = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AtCcontroller.productCount.value = 0;
      AtCcontroller.update();
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(builder: (createOrderCtlr) {
      return PopScope(
        canPop: false,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Lottie.asset('assets/lotties/OrderSuccessAnimation.json',
                        repeat: false,
                        height: getProportionateScreenHeight(250.0),
                        width: getProportionateScreenWidth(250.0)),
                    Column(
                      children: [
                        Text(
                          'Order successfully placed!',
                          style:
                              Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(8.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16.0),
                          ),
                          child: Text(
                            'Thank you for the order Your order will be prepared and shipped by given delivery date',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: kTextColorAccent,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        orderData(context, "Order Id", "Total Value", "GST",
                            "Amount", "title"),
                        const SizedBox(
                          height: 12,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: createOrderCtlr.myOrderItems.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  )),
                                  child: orderData(
                                      context,
                                      createOrderCtlr.myOrderItems[index]["id"]
                                          .toString(),
                                      createOrderCtlr.myOrderItems[index]
                                              ["total_value"]
                                          .toString(),
                                      createOrderCtlr.myOrderItems[index]
                                              ["total_gst"]
                                          .toString(),
                                      createOrderCtlr.myOrderItems[index]
                                              ["total_amount"]
                                          .toString(),
                                      "value"),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          // color: Colors.red,
                          width: Get.width,
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(flex: 1, child: Center(child: Text(""))),
                              const Expanded(flex: 1, child: Center(child: Text(""))),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                    "Total",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                getProportionateScreenWidth(15)),
                                  ))),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                          "₹ ${setTotalValue(
                                            createOrderCtlr.myOrderItems,
                                          )}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          15)))))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 260,
                      width: Get.width,
                      //  color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenWidth(16.0),
                              horizontal: getProportionateScreenWidth(16.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(TabScreen.routeName);
                              },
                              child: const Text('Continue Shopping'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  orderData(BuildContext context, String txt1, String txt2, String txt3,
      String txt4, String txt5) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(txt1,
                  style: txt5 == "title"
                      ? Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(15))
                      : Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(11))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(txt5 == "title" ? txt2 : "₹ $txt2",
                  style: txt5 == "title"
                      ? Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(15))
                      : Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(11))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(txt5 == "title" ? txt3 : "₹ $txt3",
                  style: txt5 == "title"
                      ? Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(15))
                      : Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(11))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyOrderDetail2(OrderId: int.parse(txt1))));
                  log('od id $txt1');
                },
                child: Column(
                  children: [
                    Text(txt5 == "title" ? txt4 : "₹ $txt4",
                        style: txt5 == "title"
                            ? Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(15))
                            : Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(11))),
                    txt5 == "title"
                        ? const SizedBox.shrink()
                        : const Text(
                            "ViewDetails",
                            style: TextStyle(
                              fontSize: 10,
                              color: kPrimaryBlue,
                              decoration: TextDecoration.underline,
                              decorationColor: kPrimaryBlue,
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String setTotalValue(RxList myOrderItems) {
    var amounts =
        myOrderItems.map((item) => item["total_amount"]).cast<double>();
    double totalAmount = 0.0;
    for (double amount in amounts) {
      totalAmount += amount;
    }
    log(totalAmount.toString());
    return totalAmount.toString();
  }
}
