// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../controllers/my_order_controller.dart';
import '../utils/common_functions.dart';
import '../utils/screen_utils.dart';
import '../utils/shimmer_placeholders/myorder_shimmer.dart';
import '../widgets/custom_app_bar.dart';

class MyOrderDetail2 extends StatefulWidget {
  final int OrderId;

  const MyOrderDetail2({
    super.key,
    required this.OrderId,
  });

  @override
  State<MyOrderDetail2> createState() => _MyOrderDetail2State();
}

class _MyOrderDetail2State extends State<MyOrderDetail2> {
/*  RxList? get orderList => widget.orderDetails;
  int get index => widget.index;*/

  final MyOrderController controller = Get.put(MyOrderController());
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getMyOrdersDetail(widget.OrderId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ODdatas> oddatas = [
      ODdatas(
          image:
              "http://www.dilicia.in/plugins/parallax2/images/product/full%20cream%20milk.png",
          title: "Full Cream Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
      ODdatas(
          image: "http://www.dilicia.in/images/product/Toned%20milk.png",
          title: "Tonned Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
      ODdatas(
          image:
              "http://www.dilicia.in/images/product/Doubel%20toned%20milk.png",
          title: "Double Tonned Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
      ODdatas(
          image: "http://www.dilicia.in/images/product/standerd%20milk.png",
          title: "Standardised Milk",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
      ODdatas(
          image: "http://www.dilicia.in/images/product/Ghee.png",
          title: "Buffalo Ghee",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
      ODdatas(
          image: "http://www.dilicia.in/images/product/Cow%20Ghee.png",
          title: "Cow Ghee",
          qty: "2",
          price: "20",
          total: "100",
          gst: "2",
          sgst: "2"),
    ];

    //var deviceheight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;
    return GetBuilder<MyOrderController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(
                title: "Order Details",
                actions: [],
              ),
              SizedBox(
                height: getProportionateScreenHeight(16.0),
              ),
              Container(
                  width: devicewidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: kPrimaryBlue,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text("${widget.OrderId}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                  ],
                                )),
                            controller.isLoading.value
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        convertTimestampToDateString(
                                            "${controller.orderdetailDatas["order_date"]}"),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.blueGrey,
                        thickness: 0.3,
                        height: 1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      controller.isLoading.value
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Address:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!
                                                    .copyWith(
                                                      color: kTextColorAccent,
                                                    )),
                                            Text(
                                              (controller.orderdetailDatas[
                                                              "address"]
                                                          ?["address_line1"] ??
                                                      '')
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              (controller.orderdetailDatas[
                                                              "address"]
                                                          ?["address_line2"] ??
                                                      '')
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              (controller.orderdetailDatas[
                                                              "address"]
                                                          ?["address_line3"] ??
                                                      '')
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderRateCard(
                                                context,
                                                "Total value",
                                                controller.orderdetailDatas[
                                                        "total_value"]
                                                    .toString()),
                                            orderRateCard(
                                                context,
                                                "Total gst",
                                                controller.orderdetailDatas[
                                                        "total_gst"]
                                                    .toString()),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Expanded(
                                                    flex: 1, child: Text("")),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    ("₹ ${controller.orderdetailDatas["total_amount"]}"),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    width: 130,
                                    // color: Colors.red,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8), // <-- Radius
                                          ),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.refresh,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'Reorder',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                    ],
                  )),
              SizedBox(
                height: getProportionateScreenHeight(16.0),
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: SizedBox(
                            height: 80,
                            child: ListView.builder(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.vertical,
                              itemCount: 6, // Use a placeholder count
                              itemBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.all(0),
                                  child: MyOrderShimmer(from: "orderdetail"),
                                );
                              },
                            ),
                          ),
                        )
                      : controller.hasError.value
                          ? Text('Error: ${controller.errorMsg.value}')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.myOrderDetailList.length,
                              itemBuilder: (context, index) {
                                return OrderTile(context, oddatas[index],
                                    controller.myOrderDetailList[index]);
                              }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Container OrderTile(BuildContext context, ODdatas oddata, myOrderDetailList) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    height: 80,
                    width: 80,
                    //  color: Colors.red,
                    // child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYPeQAtK8frgCvtzkLgzv513bMPi7yij6peQ&usqp=CAU",height: 50,width: 50,))
                    // child: Image.network(oddata.image,height: 50,width: 50,)),
                    child: Image.network(
                      myOrderDetailList["product"]["product_img"],
                      height: 50,
                      width: 50,
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    myOrderDetailList["product"]["name"],
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: kTextBlackColor,
                        ),
                    maxLines: 3,
                  )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ODtile(
                        "Qty:",
                        convertDoubleToString(
                            myOrderDetailList["product"]["packing_qty"])),
                    ODtile(
                        "Price:",
                        convertDoubleToString(
                            myOrderDetailList["item_price"].toString())),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ODtile(
                        "Total:",
                        convertDoubleToString(
                            myOrderDetailList["total_value"].toString())),
                    ODtile(
                        "GST:",
                        convertDoubleToString(
                            myOrderDetailList["total_gst"].toString())),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Total:",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: kTextBlackColor,
                        )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Text(
                        "₹ ${myOrderDetailList["total_amount"].toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: kTextBlackColor,
                            ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox ODtile(String title, String subtitle) {
    return SizedBox(
      // color: Colors.red.shade50,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      color: kTextColorAccent,
                    )),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 1,
            child: Text(title == "Qty:" ? subtitle : "₹ $subtitle",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: kTextBlackColor,
                    )),
          ),
        ],
      ),
    );
  }

  orderRateCard(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(key,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextColorAccent,
                fontSize: getProportionateScreenWidth(
                  12,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Text(": ₹ $value",
              style: TextStyle(
                color: kTextColorAccent,
                fontSize: getProportionateScreenWidth(
                  12,
                ),
              )),
        ),
      ],
    );
  }
}

class ODdatas {
  final String title;
  final String image;
  final String qty;
  final String price;
  final String total;
  final String gst;
  final String sgst;
  ODdatas(
      {required this.title,
      required this.image,
      required this.qty,
      required this.price,
      required this.total,
      required this.gst,
      required this.sgst});
}
