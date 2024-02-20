import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/my_order_controller.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import 'myorder_detail2.dart';

class MyOrders extends StatefulWidget {
  static const routeName = '/myOrder';
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    var deviceheight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;

    List<OrdersList> orderslist = [
      OrdersList(
          orderid: "1234",
          date: "01/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "20,000"),
      OrdersList(
          orderid: "123456",
          date: "02/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "30,000"),
      OrdersList(
          orderid: "1234567",
          date: "03/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "40,000"),
      OrdersList(
          orderid: "12345678",
          date: "04/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "50,000"),
      OrdersList(
          orderid: "123456789",
          date: "05/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "60,000"),
      OrdersList(
          orderid: "1234567890",
          date: "06/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "70,000"),
      OrdersList(
          orderid: "12345678901",
          date: "07/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "80,000"),
      OrdersList(
          orderid: "1234",
          date: "08/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "90,000"),
      OrdersList(
          orderid: "123456789012",
          date: "09/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "100000"),
      OrdersList(
          orderid: "1234567890123",
          date: "10/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "120000"),
      OrdersList(
          orderid: "12345678901234",
          date: "11/02/2024",
          address:
              "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
          amount: "130000"),
    ];

    return GetBuilder<MyOrderController>(
      init: MyOrderController(),
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'My Orders',
                  actions: [],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16.0),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(
                  () => FittedBox(
                    child: EasyStepper(
                      activeStep:
                          controller.selectedBtn.value, // activeStep.value,
                      /*   lineLength: 50,
                    lineThickness: 1,
                    lineSpace: 4,*/
                      stepRadius: 15,
                      unreachedStepIconColor: Colors.black87,
                      unreachedStepBorderColor: Colors.black54,
                      unreachedStepTextColor: Colors.grey,
                      showTitle: true,
                      // lineType: LineType.dotted,
                      // unreachedLineColor: grey,
                      finishedStepTextColor: Colors.grey,
                      finishedStepBackgroundColor: Colors.grey,
                      activeStepIconColor: Colors.blue,
                      activeStepBackgroundColor: Colors.blue,
                      activeStepTextColor: Colors.blue.shade700,
                      showLoadingAnimation: false,
                      enableStepTapping: true,
                      steps: const [
                        EasyStep(
                          customStep: Text("1"),
                          title: "Open",
                        ),
                        EasyStep(
                          customStep: Text("2"),
                          title: "Approved",
                        ),
                        EasyStep(
                          customStep: Text("3"),
                          title: "Partially \ncompleted",
                        ),
                        EasyStep(
                          customStep: Text("4"),
                          title: "Completed",
                        ),
                        EasyStep(
                          customStep: Text("5"),
                          title: "Rejected",
                        ),
                      ],
                      onStepReached: (index) {
                        controller.selectedBtn.value = index;
                        log('selected page indx $index');
                        controller.pageController.jumpToPage(index);
                        for (int i = 0;
                            i < controller.selectedFilter.length;
                            i++) {
                          controller.selectedFilter[i] = i == index;
                        }
                        controller.update();
                        controller.selectedBtn.value = index;
                      },
                      // activeStep.value = index,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: 5,
                    restorationId: "MyOrdersPage",
                    controller: controller.pageController,
                    onPageChanged: (v) async {
                      controller.selectedBtn.value = v;
                      for (int i = 0;
                          i < controller.selectedFilter.length;
                          i++) {
                        controller.selectedFilter[i] = i == v;
                      }
                      controller.update();
                    },
                    itemBuilder: (context, pageIndex) {
                      return MyOrderCards(
                        devicewidth: devicewidth,
                        orderlist: orderslist,
                        myOrderList: RxList([]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

class MyOrderCards extends StatelessWidget {
  const MyOrderCards(
      {super.key,
      required this.devicewidth,
      required this.orderlist,
      required this.myOrderList});

  final double devicewidth;
  final List<OrdersList> orderlist;
  final RxList myOrderList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orderlist.length,
        itemBuilder: (context, index) {
          return RefreshIndicator(
              onRefresh: () async {
                /* Future.sync(
                    () => controller.pagingController.refresh());*/
              },
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetail(orderdetail: orderlist[index])));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrderDetail2(
                                orderdetail: orderlist[index],
                                OrderId: 0,
                              )));
                },
                child: Container(
                    width: devicewidth,
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
                          //height: 26,
                          color: Colors.teal.shade50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Text("Order No:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: kTextColorAccent,
                                                )),
                                        Expanded(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(orderlist[index].orderid,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                        )),
                                      ],
                                    )),
                                Row(
                                  children: [
                                    Text(
                                      orderlist[index].date,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              color: kTextColorAccent,
                                            )),
                                    Text(
                                      orderlist[index].address,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(("₹ ${orderlist[index].amount}")),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
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
        });
  }

  orderIDDate(BuildContext context, int index, String title, String value) {
    return Row(
      children: [
        Icon(
          Icons.shopping_cart,
          color: title == "Order No" ? kPrimaryBlue : Colors.white,
        ),
        const SizedBox(width: 8),
        Text(title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 12,
                  color: kTextColorAccent,
                )),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
              title == "Order No"
                  ? myOrderList[index][value].toString()
                  : convertTimestampToDateString(
                      myOrderList[index][value].toString()),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
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
}
