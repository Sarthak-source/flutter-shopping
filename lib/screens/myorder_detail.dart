import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/common.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import 'myorders_screen.dart';

class MyOrderDetail extends StatefulWidget {
  static const routeName = 'myOrderDetail';
  final OrdersList orderdetail;
  const MyOrderDetail({super.key, required this.orderdetail});

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail> {
  @override
  Widget build(BuildContext context) {
    var deviceheight = Get.height;
    var devicewidth = Get.width;

    final List<TableData> tdata = [
      TableData(
          prcode: "Double Tonned Milk500 ml",
          prqty: "10",
          pruom: "crate",
          prrate: "100",
          prtotal: "1000"),
      TableData(
          prcode: "Full Cream Milk 500 ml",
          prqty: "15",
          pruom: "crate",
          prrate: "200",
          prtotal: "2000"),
      TableData(
          prcode: "Tonned Milk 500 ml",
          prqty: "20",
          pruom: "crate",
          prrate: "300",
          prtotal: "3000"),
      TableData(
          prcode: "Standardised Milk 500 ml",
          prqty: "25",
          pruom: "crate",
          prrate: "400",
          prtotal: "4000"),
      TableData(
          prcode: "Double Tonned Milk 500 ml",
          prqty: "25",
          pruom: "crate",
          prrate: "400",
          prtotal: "4000"),
      TableData(
          prcode: "Buffalo Ghee 500 ml",
          prqty: "25",
          pruom: "crate",
          prrate: "400",
          prtotal: "4000"),
      TableData(
          prcode: "Cow Ghee 500 ml",
          prqty: "25",
          pruom: "crate",
          prrate: "400",
          prtotal: "4000"),
      TableData(
          prcode: "Paneer 500 ml",
          prqty: "25",
          pruom: "crate",
          prrate: "400",
          prtotal: "4000"),
    ];

    return Scaffold(
      // backgroundColor:  kPrimaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Order Details',
              actions: [],
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  orderDetailContainer(
                      "Order No :", widget.orderdetail.orderid),
                  const SizedBox(
                    height: 16,
                  ),
                  orderDetailContainer("Order Date :", widget.orderdetail.date),
                  const SizedBox(
                    height: 16,
                  ),
                  orderDetailContainer("Order Status :", "Approved"),
                  const SizedBox(
                    height: 16,
                  ),
                  orderDetailContainer(
                      "Delivery Expected date :", widget.orderdetail.date),
                  const SizedBox(
                    height: 26,
                  ),
                  Table(
                    border: TableBorder.all(color: black),
                    children: List<TableRow>.generate((tdata.length), (ind) {
                      if (ind == 0) {
                        return TableRow(
                          children: [
                            odTableUi("Product Code"),
                            odTableUi("Product Qty"),
                            odTableUi("UOM"),
                            odTableUi("Rate"),
                            odTableUi("Total"),
                          ],
                        );
                      }
                      int lind = ind - 1;
                      return TableRow(
                          decoration: BoxDecoration(color: setTabColor(ind)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                tdata[ind].prcode,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                tdata[ind].prqty,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                tdata[ind].pruom,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                tdata[ind].prrate,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                tdata[ind].prtotal,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ]);
                    }),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  SizedBox(
                    width: devicewidth,
                    // color: Colors.red.shade50,
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Total :",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: kTextBlackColor,
                                        )))),
                        Text("₹ 25000",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kTextBlackColor,
                                ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  odTableUi(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
          )),
    );
  }

  orderDetailContainer(String title, String values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kTextColorAccent,
                  ),
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: Text(values,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: values == "Approved"
                          ? kTextGreenColor
                          : kTextBlackColor,
                    ))),
      ],
    );
  }

  setTabColor(int ind) {
    if (ind % 2 == 0) {
      return kPrimaryBlue.withOpacity(0.4);
    } else {
      return Colors.white;
    }
  }
}

class TableData {
  String prcode;
  String prqty;
  String pruom;
  String prrate;
  String prtotal;

  TableData({
    required this.prcode,
    required this.prqty,
    required this.pruom,
    required this.prrate,
    required this.prtotal,
  });
}
