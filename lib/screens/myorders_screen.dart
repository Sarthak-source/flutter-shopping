import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/my_order_controller.dart';

import '../config/common.dart';
import '../constants/colors.dart';
import '../utils/common_functions.dart';
import '../utils/screen_utils.dart';
import '../utils/shimmer_placeholders/myorder_shimmer.dart';
import 'myorder_detail2.dart';

class MyOrders extends StatefulWidget {
  static const routeName = '/myOrder';
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  String? add1 = '';
  String? add2 = '';
  String? add3 = '';
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    final MyOrderController controller = Get.put(MyOrderController());
     pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.selectedBtn.value = 1;
      //if (controller.pageController != null) {
     // controller.pageController = PageController();
      pageController.jumpToPage(1);
     // }
      controller.myOrderList.clear();
      controller.update();
    //  controller.getMyOrders("Approved","1");
      Map storedUserData = box!.get('userData');
      print(
          'userdata in myOrderScreen ${storedUserData['party']['address']['address_line1'].toString()}');
      add1 = storedUserData['party']['address']['address_line1'].toString() ?? "";
      add2 = storedUserData['party']['address']['address_line2'].toString() ?? "";
      add3 = storedUserData['party']['address']['address_line3'].toString() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceheight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GetBuilder<MyOrderController>(
        init: MyOrderController(),
        autoRemove: false,
        builder: (controllerrr) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Text(
                          'My Orders',
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
                      () => FittedBox(
                        child: EasyStepper(

                          activeStep:
                          controllerrr.selectedBtn.value, // activeStep.value,
                          /*   lineLength: 50,
                        lineThickness: 1,
                        lineSpace: 4,*/
                          stepRadius: 15,
                          unreachedStepIconColor: Colors.black,
                          unreachedStepBorderColor: Colors.black,
                          unreachedStepTextColor: Colors.grey,
                            unreachedStepBackgroundColor: Colors.grey,
                          showTitle: true,
                          // lineType: LineType.dotted,
                          // unreachedLineColor: grey,
                          finishedStepTextColor: Colors.black,
                          finishedStepBackgroundColor: Colors.grey,
                          finishedStepBorderColor: Colors.black,
                          activeStepIconColor: kPrimaryBlue,
                          activeStepBackgroundColor: kPrimaryBlue,
                          activeStepTextColor: kPrimaryBlue,

                          showLoadingAnimation: false,
                          enableStepTapping: true,

                          steps: [
                            EasyStep(
                              customStep: Text(
                                "1",//"${controllerrr.selectedBtn.value.toString()}",
                                style: TextStyle(
                                  color:  controllerrr.selectedBtn.value == 0?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "Created",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                            EasyStep(
                              customStep: Text(
                                "2",
                                style: TextStyle(
                                    color:  controllerrr.selectedBtn.value == 1?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "Approved",
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                            EasyStep(
                              customStep: Text(
                                "3",
                                style: TextStyle(
                                    color:  controllerrr.selectedBtn.value == 2?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "Rejected",
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                            EasyStep(
                              customStep: Text(
                                "4",
                                style: TextStyle(
                                    color:  controllerrr.selectedBtn.value == 3?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "Cancelled",
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                            EasyStep(
                              customStep: Text(
                                "5",
                                style: TextStyle(
                                    color:  controllerrr.selectedBtn.value == 4?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "In Progress",
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                            EasyStep(
                              customStep: Text(
                                "6",
                                style: TextStyle(
                                    color:  controllerrr.selectedBtn.value == 5?Colors.white:Colors.black,
                                    fontSize: Get.width >= 600 ? 13 : 10),
                              ),
                              customTitle: Text(
                                "Completed",
                                style: TextStyle(
                                    fontSize: Get.width >= 600 ? 13 : 11),
                              ),
                            ),
                          ],
                          onStepReached: (index) => _onStepReached(index,controllerrr)


                          /*    (index) {
                            controller.selectedBtn.value = index;
                            print('selected page indx $index');
                            controller.pageController.jumpToPage(index);
                            controller.update();
                            for (int i = 0;
                                i < controller.selectedFilter.length;
                                i++) {
                              controller.selectedFilter[i] = i == index;
                            }
                            controller.update();
                            controller.selectedBtn.value = index;
                          },*/
                          // activeStep.value = index,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 60,
                      width: Get.width,
                      // color: Colors.red.shade50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${add1 ?? ""} ${add2 ?? ""}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),

                                      /* Expanded(
                                        flex:1,
                                        child: Text(setAddress(controller.myOrderList.isEmpty?"":controller.myOrderList[0]["address"],"address_line2"), style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                          maxLines: 1,
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  Text(
                                    add3 ?? "",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: 6,
                        restorationId: "MyOrdersPage",
                        controller: pageController,
                        onPageChanged: (v) async {
                          log('page Number:: $v');
                          controllerrr.selectedBtn.value = v;
                          controllerrr.myOrderList.clear();
                          controllerrr.update();
                          if (v == 0) {
                            controllerrr.getMyOrders("Created","1");
                          } else if (v == 1) {
                            controllerrr.getMyOrders("Approved","1");
                          } else if (v == 2) {
                            controllerrr.getMyOrders("Rejected","1");
                          } else if (v == 3) {
                            controllerrr.getMyOrders("Cancelled","1");
                          } else if (v == 4) {
                            controllerrr.getMyOrders("InProgress","1");
                          } else {
                            controllerrr.getMyOrders("Completed","1");
                          }

                          for (int i = 0; i < controllerrr.selectedFilter.length; i++) {
                            controllerrr.selectedFilter[i] = i == v;
                          }
                          controllerrr.update();
                        },
                        itemBuilder: (context, pageIndex) {
                          if (!controllerrr.isLoading.value) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.vertical,
                                  itemCount: 6, // Use a placeholder count
                                  itemBuilder: (context, index) {
                                    return const Padding(
                                      padding: EdgeInsets.all(0),
                                      child: MyOrderShimmer(from: "myorder"),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else if (controllerrr.hasError.value) {
                            return Text('Error: ${controllerrr.errorMsg.value}');
                          } else {
                            if (controllerrr.myOrderList.isEmpty) {
                              return Column(
                                children: [
                                  Lottie.asset('assets/lotties/no-data.json',
                                      repeat: false,
                                      height:
                                          getProportionateScreenHeight(250.0),
                                      width:
                                          getProportionateScreenWidth(250.0)),
                                  SizedBox(
                                      height:
                                          getProportionateScreenHeight(10.0)),
                                  const Text(
                                    'No orders found',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryBlue),
                                  ),
                                ],
                              );
                            } else {
                              return MyOrderCards(
                                  devicewidth: devicewidth,
                                  myOrderList: controllerrr.myOrderList);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onStepReached(int index, MyOrderController controller) {
    controller.selectedBtn.value = index;
    print('selected page indx $index');
    pageController.jumpToPage(index);
    controller.update();
    for (int i = 0;
    i < controller.selectedFilter.length;
    i++) {
      controller.selectedFilter[i] = i == index;
    }
    controller.update();
    controller.selectedBtn.value = index;

// activeStep.value = index,
  }
}

class OrdersList {
  String orderid;
  String address;
  String date;
  String amount;
  OrdersList(
      {required this.orderid,
      required this.address,
      required this.date,
      required this.amount});
}

class MyOrderCards extends StatefulWidget {
  const MyOrderCards(
      {super.key, required this.devicewidth, required this.myOrderList});

  final double devicewidth;

  final RxList myOrderList;

  @override
  State<MyOrderCards> createState() => _MyOrderCardsState();
}

class _MyOrderCardsState extends State<MyOrderCards> {
  ScrollController? _scrollController;
  double? _scrollPosition = 0.0;
  int pageNum = 1;
  final MyOrderController controller = Get.put(MyOrderController());
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollPosition == 0) {
        print('At top');
        //  print('_scrollPosition... ${_scrollPosition}');
      } else {

        //  _scrollController.position.pixels == _scrollController.position.maxScrollExtent
        //  print('_scrollPosition... ${_scrollPosition} and max scroll ${_scrollController?.position.maxScrollExtent}');
        if (_scrollPosition == _scrollController?.position.maxScrollExtent) {
          print('At bottom');
          print('selected tab:: ${controller.selectedBtn.value}');
          if(controller.selectedBtn.value ==1){
            if(controller.nxt.value != null && controller.nxt.value != ""){
              pageNum++;
              controller.getMyOrders("Approved",pageNum.toString());
            }

          }
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              // itemCount: orderlist.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: widget.myOrderList.length,
              itemBuilder: (context, index) {
                return RefreshIndicator(
                    onRefresh: () async {
                      /* Future.sync(
                          () => controller.pagingController.refresh());*/
                    },
                    child: GestureDetector(
                      onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetail(orderdetail: orderlist[index])));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderDetail2(
                                    OrderId: widget.myOrderList[index]["id"])));
                      },
                      child: Container(
                          width: widget.devicewidth,
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.grey.shade300,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Icon(
                                          Icons.shopping_cart,
                                          color: kPrimaryBlue,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              orderIDDate(
                                                  context, index, "Order No", "order_num"),
                                              orderIDDate(context, index, "Date",
                                                  "order_date"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.blueGrey,
                                      thickness: 0.3,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    /* Icon(Icons.location_on_outlined,color: Colors.grey,),
                                const SizedBox(width: 8,),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(setAddress(myOrderList[index]["address"],"address_line1"), style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                      ),
                                      Text(setAddress(myOrderList[index]["address"],"address_line2"), style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                      ),
                                      Text(setAddress(myOrderList[index]["address"],"address_line3"), style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),*/
                                    Expanded(
                                      // flex:2,
                                      child: Column(
                                        children: [
                                          orderRateCard(
                                              context,
                                              "Delivery Required On",
                                              setDelvReqDate(widget.myOrderList[index]
                                                      ["delivery_required_on"]
                                                  .toString()),
                                              true),
                                          const SizedBox(height: 8),
                                          orderRateCard(
                                              context,
                                              "Total Basic Amount",
                                              widget.myOrderList[index]["total_value"]
                                                  .toString(),
                                              false),
                                          orderRateCard(
                                              context,
                                              "Total GST",
                                              widget.myOrderList[index]["total_gst"]
                                                  .toString(),
                                              false),
                                          orderRateCard(
                                              context,
                                              "Total",
                                              widget.myOrderList[index]["total_amount"]
                                                  .toString(),
                                              false)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  // color: Colors.red,
                                  decoration: const BoxDecoration(
                                    // color: Colors.red.shade50,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.6,
                                          color: Colors.grey,
                                          style: BorderStyle.solid), //BorderSide
                                    ), //
                                  ),
                                  width: Get.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order Summary",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: kTextColorAccent,
                                                fontSize:
                                                    getProportionateScreenWidth(14),
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            // height: 50,
                                            width: Get.width,
                                            decoration: const BoxDecoration(
                                              // color: Colors.red.shade50,
                                              border: Border(
                                                top: BorderSide(
                                                    width: 0.6,
                                                    color: Colors.grey,
                                                    style: BorderStyle
                                                        .solid), //BorderSide
                                                //BorderSide
                                                left: BorderSide(
                                                    width: 0.6,
                                                    color: Colors.grey,
                                                    style: BorderStyle
                                                        .solid), //Borderside
                                                right: BorderSide(
                                                    width: 0.6,
                                                    color: Colors.grey,
                                                    style: BorderStyle
                                                        .solid), //BorderSide
                                              ), //
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // Text(setCount(MyOrderList[index]["order_items"][index]["count"]),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "Product Name",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: kTextColorAccent,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  12),
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Quantity",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: kTextColorAccent,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  12),
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "UOM",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: kTextColorAccent,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  12),
                                                        ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: widget.myOrderList[index]
                                                    ["order_items"]
                                                .length,
                                            itemBuilder: (context, newindex) {
                                              return Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Container(
                                                  // height: 50,
                                                  width: Get.width,
                                                  decoration: const BoxDecoration(
                                                    // color: Colors.red.shade50,
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.6,
                                                          color: Colors.grey,
                                                          style: BorderStyle
                                                              .solid), //BorderSide
                                                      //BorderSide
                                                      left: BorderSide(
                                                          width: 0.6,
                                                          color: Colors.grey,
                                                          style: BorderStyle
                                                              .solid), //Borderside
                                                      right: BorderSide(
                                                          width: 0.6,
                                                          color: Colors.grey,
                                                          style: BorderStyle
                                                              .solid), //BorderSide
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          widget.myOrderList[index]
                                                                      ["order_items"]
                                                                  [newindex]
                                                              ["product"]["name"],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: Get.width >= 600
                                                                ? 22
                                                                : 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          convertDoubleToString(
                                                              widget.myOrderList[index]
                                                                      ["order_items"][
                                                                  newindex]["count"]),
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: Get.width >= 600
                                                                ? 22
                                                                : 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          widget.myOrderList[index]
                                                                      ["order_items"][
                                                                  newindex]["product"]
                                                              ["order_uom"],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: Get.width >= 600
                                                                ? 22
                                                                : 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    )

                    /*PagedListView<int, dynamic>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  firstPageProgressIndicatorBuilder: (context) {
                    return const SizedBox();
                  },
                  newPageErrorIndicatorBuilder: (context) {
                    return SizedBox(
                      height: Get.height * .7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No Orders available"),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Add Order"),
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder:(context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                      child: Column(
                        children: [
                          const Text("No Orders Available In \nThis Status.",style: TextStyle(
                            fontSize: 20,
                          ),textAlign: TextAlign.center,),
                          height(15),
                          const Text("Check Other Status."),
                        ],
                      ),
                    );
                  },

                  firstPageErrorIndicatorBuilder: (context) {
                    return const Column(
                      children: [Text("No Data")],
                    );
                  },

                itemBuilder: (context, item, index){
                  return Container(
                      height: 200,
                      width: 200,
                      color: Colors.red.shade50,
                      child: Text(pageIndex.toString()));
                }
              ),

            ),*/
                    );
              }),
          Container(
            height: 200,
            width: Get.width,
          )
        ],
      ),
    );
  }

  orderRateCard(BuildContext context, String key, String value, bool isdate) {
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
          child: Text(
              isdate
                  ? "$value"
                  : ": ₹ ${twodecimalDigit(double.parse(value == null ? "0.000" : value))}",
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

  orderIDDate(BuildContext context, int index, String title, String value) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text("$title :",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 12,
                  color: title == "Order No" ? Colors.black : kTextColorAccent,
                )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
              title == "Order No"
                  ? widget.myOrderList[index][value].toString()
                  : convertTimestampToDateString(
                      widget.myOrderList[index][value].toString()),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 10,
                    color:
                        title == "Order No" ? Colors.black : kTextColorAccent,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  String setCount(myOrderList) {
    double d = double.parse(myOrderList);
    String s = d.toString();
    return s;
  }

  String setDelvReqDate(String delReqDate) {
    if (delReqDate != null && delReqDate != "") {
      return ":${convertTimestampToDateString(delReqDate)}";
    } else {
      return "";
    }
  }
}

setAddress(myOrderList, String s) {
  log(myOrderList.toString());
  log(s.toString());
  if (myOrderList != null) {
    return myOrderList[s].toString();
  } else {
    return "";
  }
}
