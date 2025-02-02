import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/common_controller.dart';
import '../../utils/common_functions.dart';
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
  final AddToCartController atCcontroller = Get.put(AddToCartController());
  final CommonController cmncontroller = Get.put(CommonController());
  double totalamt = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      atCcontroller.productCount.value = 0;
      atCcontroller.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CommonController cmncontroller = Get.put(CommonController());

    return GetBuilder<MyCartController>(builder: (createOrderCtlr) {
      return WillPopScope(
        onWillPop: () async {
         // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          cmncontroller.commonCurTab.value=0;
          cmncontroller.update();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const TabScreen(),
            ),
          );
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Lottie.asset(
                        'assets/lotties/OrderSuccessAnimation.json',
                        repeat: false,
                        height: getProportionateScreenHeight(200.0),
                        width: getProportionateScreenWidth(200.0),
                      ),
                      Text(
                        'Order Successfully Placed!',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8.0)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(16.0),
                        ),
                        child: Text(
                          'Thank you for the order. Your order will be Processed.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: kTextColorAccent,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: Get.width,
                        child: DataTable(
                          columnSpacing: 40,
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Order\nId',
                              maxLines: 2,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataColumn(
                                label: Text(
                              'Total \nValue',
                              maxLines: 2,
                              style: TextStyle(fontSize: 12),
                            )),
                            DataColumn(
                                label: Text(
                              'GST',
                              style: TextStyle(fontSize: 12),
                            )),
                            DataColumn(
                                label: Text(
                              'Amount',
                              style: TextStyle(fontSize: 12),
                            )),
                          ],
                          rows: createOrderCtlr.myOrderItems.map((item) {
                            return DataRow(

                              cells: [
                                DataCell(
                                  Column(
                                    children: [
                                      SizedBox(height: 6),
                                      Text(
                                        item["id"] == null
                                            ? ""
                                            : item["id"].toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Column(
                                    children: [
                                      SizedBox(height: 6),
                                      Text(
                                        item["total_value"] == null
                                            ? ""
                                            : twodecimalDigit(double.parse(
                                                item["total_value"].toString())),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Column(
                                    children: [
                                      SizedBox(height: 6),
                                      Text(
                                        item["total_gst"] == null
                                            ? ""
                                            : twodecimalDigit(double.parse(
                                                item["total_gst"].toString())),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyOrderDetail2(
                                            OrderId: int.parse(
                                                item["id"].toString()),
                                          ),
                                        ),
                                      );
                                      log('od id ${item["id"].toString()}');
                                    },
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                         // SizedBox(height: 5),
                                          Text(
                                            item["total_amount"] == null
                                                ? ""
                                                : twodecimalDigit(double.parse(
                                                    item["total_amount"]
                                                        .toString())),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          if (item["title"] != "title")
                                         InkWell(
                                           onTap:() {
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(
                                                 builder: (context) =>
                                                     MyOrderDetail2(
                                                       OrderId: int.parse(
                                                           item["id"]
                                                               .toString()),
                                                     ),
                                               ),
                                             );
                                           },
                                           child: const Text(
                                                  "View Details",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: kPrimaryBlue,
                                                    decoration:
                                                        TextDecoration.underline,
                                                    decorationColor: kPrimaryBlue,
                                                  ),
                                                ),
                                         ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Expanded(
                              child: SizedBox.shrink(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Total :",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "₹ ${twodecimalDigit(double.parse(setTotalValue(createOrderCtlr.myOrderItems).toString()))}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenWidth(16.0),
                            horizontal: getProportionateScreenWidth(16.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              cmncontroller.commonCurTab.value = 0;
                              cmncontroller.update();
                              Navigator.of(context)
                                  .pushReplacementNamed(TabScreen.routeName);
                            },
                            child: const Text('Continue Shopping'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String setTotalValue(RxList myOrderItems) {
    var amounts =
        myOrderItems.map((item) => item["total_amount"]).cast<String>();
    double totalAmount = 0.0;
    for (String amount in amounts) {
      totalAmount += double.parse(amount);
    }
    log(totalAmount.toString());
    return totalAmount.toString();
  }
}
