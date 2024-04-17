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
import '../widgets/order_card.dart';

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
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderRateCard(
                                                context,
                                                "Total Basic Amt", twodecimalDigit(double.parse(controller.orderdetailDatas["total_value"]==null?"0.000":controller.orderdetailDatas["total_value"].toString()))),
                                            orderRateCard(
                                                context,
                                                "Total GST", twodecimalDigit(double.parse(controller.orderdetailDatas["total_gst"]==null?"0.000":controller.orderdetailDatas["total_gst"].toString()))),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Expanded(
                                                    flex: 1, child: Text("")),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    ("₹ ${twodecimalDigit(double.parse(controller.orderdetailDatas["total_amount"]==null?"0.000":controller.orderdetailDatas["total_amount"].toString()))}"),
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
                                        onPressed: () {
                                          controller.reOrderApi(widget.OrderId.toString());
                                        },
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
                               // return OrderTile(context, controller.myOrderDetailList[index]);
                             return Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                               child: orderDetailNewTile(myOrderDetailList: controller.myOrderDetailList[index]),
                             );

                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Container OrderTile(BuildContext context, myOrderDetailList) {
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

class orderDetailNewTile extends StatelessWidget {
  dynamic myOrderDetailList;
   orderDetailNewTile( {
    super.key,
    this.myOrderDetailList
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(80),
                child: Image.network(
                  myOrderDetailList["product"]["product_img"] ?? "http://170.187.232.148/static/images/dilicia.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(8),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            myOrderDetailList["product"]["name"] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    rateCard(
                      "Qty ",
                      "${twodecimalDigit(double.parse( convertDoubleToString(myOrderDetailList["count"] ??"0.000") ))}",
                    ),rateCard(
                      "Price ",
                      "${twodecimalDigit(double.parse(convertDoubleToString(myOrderDetailList["item_price"] ==null?"0.000":myOrderDetailList["item_price"].toString()) ))} / ${myOrderDetailList["product"]['order_uom'] ?? ""}",
                    ),
                    rateCard(
                        "Basic Amount ",
                        twodecimalDigit(double.parse(convertDoubleToString(myOrderDetailList["total_value"]==null?"0.000":myOrderDetailList["total_value"].toString())))),
                    rateCard(
                        "GST ",
                        twodecimalDigit(double.parse(convertDoubleToString(myOrderDetailList["total_gst"]==null?"0.000":myOrderDetailList["total_gst"].toString())))),


                    /*    Text(
                            widget.mycartItem["total_value"].toString(),
                            style: TextStyle(
                              color: kTextColorAccent,
                              fontSize: getProportionateScreenWidth(
                                12,
                              ),
                            ),
                          ),
                          Text(
                            widget.mycartItem["total_gst"].toString(),
                            style: TextStyle(
                              color: kTextColorAccent,
                              fontSize: getProportionateScreenWidth(
                                12,
                              ),
                            ),
                          ),*/

                    Row(
                      children: [
                        Text(
                          '₹ ${twodecimalDigit(double.parse( myOrderDetailList["total_amount"]==null?"0.000":myOrderDetailList["total_amount"].toString() ))}',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),

                        /* Card(
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
     width:  quantity == 0 ? 75
         : ( quantity.toString().length * 11) + 75,
     child:  quantity == 0
         ? OutlinedButton(
             style: OutlinedButton.styleFrom(
               side: const BorderSide(color: kPrimaryBlue),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(
                     10.0), // Set your desired border radius
               ),
             ),
             onPressed: () {
               log('widget.mycartItem["product"]["name"] ${widget.mycartItem["product"]["name"].toString()}');
                 setState(() {
                 quantity++;
                 log(quantity.toString());
                 widget.onAddItem(quantity);
               });
             },
             child: const Text(
               'Add',
               style: TextStyle(
                   color: kPrimaryBlue, fontSize: 14),
             ),
           )
         : PlusMinusUI(
       onPlusPressed: (){
             setState(() {
               quantity++;
               widget.onPlusinCard(quantity);
             });
             },
           onMinusPressed: (){
             if (quantity != 0) {
               setState(() {
                 quantity--;
                 widget.onMinusinCard(quantity);
               });

             }
           },
           qty: quantity,
     ),
         // :


                                ),
                              ),*/

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row rateCard(String keyy, String? values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            keyy,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(
                12,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            setQty(keyy,values),
           // keyy == "Qty" ? ":   ${convertDoubleToString(values ?? "")}" :  ":  ₹ ${values ?? ""}",
            //widget.mycartItem["product"]["price"].toString(),
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(
                12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String setQty(String keyy, String? values) {
    if(keyy == "Qty " ){
      return ":   ${convertDoubleToString(values ?? "")}";
    }else{
      return  ":  ₹ ${values ?? ""}";
    }
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
