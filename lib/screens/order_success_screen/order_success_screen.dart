import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../tab_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const routeName = '/orderSuccess';
  final MyCartController controller = Get.put(MyCartController());
  OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(builder: (createOrderCtlr) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset('assets/lotties/OrderSuccessAnimation.json',
                    repeat: false,
                    height: getProportionateScreenHeight(250.0),
                    width: getProportionateScreenWidth(250.0)),
                Column(
                  children: [
                    Text(
                      'Order successfully placed!',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                        'Thank you for the order Your order will be prepared and shipped by courier within 1-2 days',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kTextColorAccent,
                            ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: createOrderCtlr.myOrderItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey, // Set border color
                                  width: 1, // Set border width
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    orderDetailsUI(context, createOrderCtlr,
                                        index, "Order Id", "id"),
                                    //  OrderDetailsUI(context, CreateOrderCtlr, index,"Order Date", "order_date"),
                                    //OrderDetailsUI(context, CreateOrderCtlr, index,"Delivery Date", "delivery_required_on"),
                                    orderDetailsUI(context, createOrderCtlr,
                                        index, "Total Value", "total_value"),
                                    orderDetailsUI(context, createOrderCtlr,
                                        index, "Total GST", "total_gst"),
                                    orderDetailsUI(context, createOrderCtlr,
                                        index, "Total", "total_amount"),

                                    /*Text(CreateOrderCtlr.myOrderItems[index]["order_date"].toString()),
                                    Text(CreateOrderCtlr.myOrderItems[index]["delivery_required_on"].toString()),
                                    Text(CreateOrderCtlr.myOrderItems[index]["total_value"].toString()),
                                    Text(CreateOrderCtlr.myOrderItems[index]["total_gst"].toString()),
                                    Text(CreateOrderCtlr.myOrderItems[index]["total_amount"].toString()),*/
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
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
        ),
      );
    });
  }

  orderDetailsUI(BuildContext context, MyCartController createOrderCtlr,
      int index, String title, String key) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(14),
                  ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              flex: 1,
              //child: Text(": ${CreateOrderCtlr.myOrderItems[index][key].toString()}")),
              child: Text(
                  "${setValue(context, createOrderCtlr, index, title, key)}")),
        ],
      ),
    );
  }

  String convertTimestampToDateString(String timestampString) {
    // Parse the timestamp string to a DateTime object
    DateTime dateTime = DateTime.parse(timestampString);

    // Format the DateTime object as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);

    return formattedDate;
  }

  setValue(BuildContext context, MyCartController createOrderCtlr, int index,
      String title, String key) {
    if (title == "Order Date") {
      return ": ${convertTimestampToDateString(createOrderCtlr.myOrderItems[index][key].toString())}";
    } else {
      return ": ${createOrderCtlr.myOrderItems[index][key].toString()}";
    }
  }
}
