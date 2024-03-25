import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/my_order_controller.dart';

import '../constants/colors.dart';
import '../utils/common_functions.dart';
import '../utils/screen_utils.dart';
import '../utils/shimmer_placeholders/myorder_shimmer.dart';
import '../widgets/custom_app_bar.dart';
import 'myorder_detail.dart';
import 'myorder_detail2.dart';

class MyOrders extends StatefulWidget {
  static const routeName = '/myOrder';
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final MyOrderController controller = Get.put(MyOrderController());

  @override
  void initState() {
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          controller.selectedBtn.value = 1;
          controller.update();
          controller.getMyOrders("Approved");
        });

  }

  @override
  Widget build(BuildContext context) {

    var deviceheight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;

    List<OrdersList> orderslist = [
      OrdersList(
        orderid: "1234",
        date: "01/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "20,000"
      ),  OrdersList(
        orderid: "123456",
        date: "02/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "30,000"
      ),  OrdersList(
        orderid: "1234567",
        date: "03/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "40,000"
      ),  OrdersList(
        orderid: "12345678",
        date: "04/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "50,000"
      ),  OrdersList(
        orderid: "123456789",
        date: "05/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "60,000"
      ),  OrdersList(
        orderid: "1234567890",
        date: "06/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "70,000"
      ),  OrdersList(
        orderid: "12345678901",
        date: "07/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "80,000"
      ),  OrdersList(
        orderid: "1234",
        date: "08/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "90,000"
      ),  OrdersList(
        orderid: "123456789012",
        date: "09/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "100000"
      ),  OrdersList(
        orderid: "1234567890123",
        date: "10/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "120000"
      ),  OrdersList(
        orderid: "12345678901234",
        date: "11/02/2024",
        address: "No 101-E, 1st floor, Farah Winsford, 133, Infantry Rd, Shivaji Nagar, Bengaluru, Karnataka 560001",
        amount: "130000"
      ),

    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<MyOrderController>(
        init: MyOrderController(),
         autoRemove: false,
          builder:(controller){
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(  horizontal: 16.0,),
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
                          activeStep: controller.selectedBtn.value, // activeStep.value,
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
                          activeStepIconColor: kPrimaryBlue,
                          activeStepBackgroundColor: kPrimaryBlue,
                          activeStepTextColor: kPrimaryBlue,
                          showLoadingAnimation: false,
                          enableStepTapping: true,
                          steps: const [
                            EasyStep(
                              customStep: Text("1"),
                              title: "Created",
                            ),
                            EasyStep(
                              customStep: Text("2"),
                              title: "Approved",
                            ),
                            EasyStep(
                              customStep: Text("3"),
                              title: "Rejected",
                            ),
                            EasyStep(
                              customStep: Text("4"),
                              title: "Cancelled",
                            ),
                            EasyStep(
                              customStep: Text("5"),
                              title: "InProgress",
                            ),
                            EasyStep(
                              customStep: Text("6"),
                              title: "Completed",
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
                    Container(
                     // height: 60,
                      width: Get.width,
                     // color: Colors.red.shade50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 8,),
                          const Icon(Icons.location_on_outlined,color: Colors.grey,),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Row(
                                    children: [

                                      Expanded(
                                        child: Text("${setAddress(controller.myOrderList.isEmpty?"":controller.myOrderList[0]["address"],"address_line1")} ${setAddress(controller.myOrderList.isEmpty?"":controller.myOrderList[0]["address"],"address_line2")}", style: TextStyle(
                                            color: Colors.black,
                                          fontSize: 12,
                                            fontWeight: FontWeight.normal,),
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

                                  Text(setAddress(controller.myOrderList.isEmpty?"":controller.myOrderList[0]["address"],"address_line3"), style: const TextStyle(
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
                         controller: controller.pageController,
                        onPageChanged: (v) async {
                          log('page Number:: $v');
                          controller.selectedBtn.value = v;
                          controller.update();
                         if(v == 0){
                           controller.getMyOrders("Created");
                         }else if(v == 1){
                           controller.getMyOrders("Approved");
                         }else if(v == 2){
                           controller.getMyOrders("Rejected");
                         }else if(v == 3){
                           controller.getMyOrders("Cancelled");
                         }else if(v == 4){
                           controller.getMyOrders("InProgress");
                         }else {
                           controller.getMyOrders("Completed");
                         }

                        for (int i = 0;
                        i < controller.selectedFilter.length;
                        i++) {
                          controller.selectedFilter[i] = i == v;
                        }
                        controller.update();
                        },
                        itemBuilder: (context, pageIndex) {
                       if (controller.isLoading.value) {
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
                          }else if (controller.hasError.value) {
                         return Text('Error: ${controller.errorMsg.value}');
                       }else {

                         if (controller.myOrderList.isEmpty) {
                           return Column(
                             children: [
                               Lottie.asset('assets/lotties/no-data.json',
                                   repeat: false,
                                   height: getProportionateScreenHeight(250.0),
                                   width: getProportionateScreenWidth(250.0)),
                               SizedBox(height: getProportionateScreenHeight(10.0)),
                               const Text(
                                 'No orders found',
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600, color: kPrimaryBlue),
                               ),
                             ],
                           );
                         }else{

                         return MyOrderCards(devicewidth: devicewidth,orderlist: orderslist,myOrderList:controller.myOrderList);}
                       }
                       },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          } ,

      ),
    );
  }
}

class OrdersList {
  String orderid;
  String address;
  String date;
  String amount;
  OrdersList({
     required this.orderid,
    required this.address,
    required  this.date,
    required this.amount
});
}

class MyOrderCards extends StatelessWidget {
  const MyOrderCards({
    super.key,
    required this.devicewidth,
    required this.orderlist,
    required this.myOrderList
  });

  final double devicewidth;
  final List<OrdersList> orderlist;
  final RxList myOrderList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       // itemCount: orderlist.length,
        itemCount: myOrderList.length,
        itemBuilder: (context,index) {
     return RefreshIndicator(
          onRefresh: ()async{
           /* Future.sync(
                    () => controller.pagingController.refresh());*/
          },
          child: GestureDetector(
            onTap: (){
           //  Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetail(orderdetail: orderlist[index])));
             Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderDetail2(OrderId: myOrderList[index]["id"])));
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
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              const SizedBox(width: 8,),
                              const Icon(
                                Icons.shopping_cart,
                                color: kPrimaryBlue,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    orderIDDate(context, index,"Order No","id"),
                                    orderIDDate(context, index,"Date","order_date"),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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

                           orderRateCard(context,"Delivery required on",  setDelvReqDate(myOrderList[index]["delivery_required_on"].toString()),true),
                            SizedBox(height: 8),
                            orderRateCard(context,"Total value",myOrderList[index]["total_value"].toString(),false),
                            orderRateCard(context,"Total gst",myOrderList[index]["total_gst"].toString(),false),
                            orderRateCard(context,"Total",myOrderList[index]["total_amount"].toString(),false)
                                  ],
                                ),
                      )
                            ],
                          ),
                        ),
                    Container(
                     // color: Colors.red,
                        decoration: BoxDecoration(
                         // color: Colors.red.shade50,
                          border: Border(
                            bottom: BorderSide(
                                width: 0.6,
                                color: Colors.grey,
                                style: BorderStyle.solid), //BorderSide

                          ), //
                        ),
                      width: Get.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Summary",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: kTextColorAccent,
                            fontSize: getProportionateScreenWidth(14),
                          ),),
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
                                          style: BorderStyle.solid), //BorderSide
                                       //BorderSide
                                      left: BorderSide(
                                          width: 0.6,
                                          color: Colors.grey,
                                          style: BorderStyle.solid), //Borderside
                                      right: BorderSide(
                                          width: 0.6,
                                          color: Colors.grey,
                                          style: BorderStyle.solid), //BorderSide
                                    ), //
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Text(setCount(MyOrderList[index]["order_items"][index]["count"]),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex:3,
                                      child: Text("Product Name",
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: kTextColorAccent,
                                          fontSize: getProportionateScreenWidth(12),
                                        ),),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: Text("Quantity",
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: kTextColorAccent,
                                          fontSize: getProportionateScreenWidth(12),
                                        ),),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: Text("UOM",
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: kTextColorAccent,
                                          fontSize: getProportionateScreenWidth(12),
                                        ),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: myOrderList[index]["order_items"].length,
                              itemBuilder: (context,newindex){
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                   // height: 50,
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                       // color: Colors.red.shade50,
                                      border:Border(
                                        top: BorderSide(
                                            width: 0.6,
                                        color: Colors.grey,
                                        style: BorderStyle.solid), //BorderSide
                                    //BorderSide
                                    left: BorderSide(
                                        width: 0.6,
                                        color: Colors.grey,
                                        style: BorderStyle.solid), //Borderside
                                    right: BorderSide(
                                        width: 0.6,
                                        color: Colors.grey,
                                        style: BorderStyle.solid), //BorderSide
                                  ),
                                ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          flex:4,
                                          child: Text(myOrderList[index]["order_items"][newindex]["product"]["name"],

                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Text(convertDoubleToString(myOrderList[index]["order_items"][newindex]["count"]),

                                            style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Text(myOrderList[index]["order_items"][newindex]["product"]["order_uom"],

                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),),
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
      );}
    );
  }

   orderRateCard(BuildContext context,String key,String value,bool isdate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex:1,
          child: Text(key, style: TextStyle(
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
     isdate?"$value": ": ₹ ${twodecimalDigit(double.parse(value==null?"0.000":value))}",
              style: TextStyle(
                color: kTextColorAccent,
                fontSize: getProportionateScreenWidth(
                  12,
                ),
              )
          ),
        ),
      ],
    );
  }

   orderIDDate(BuildContext context, int index,String title,String value) {
    return Row(
      children: [

        const SizedBox(width: 8),
        Text("$title :",

            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 12,
              color: title=="Order No" ?Colors.black :kTextColorAccent,
                )),
        Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(title=="Order No" ?myOrderList[index][value].toString():
                  convertTimestampToDateString(myOrderList[index][value].toString()),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 10,
                        color: title=="Order No" ?Colors.black :kTextColorAccent,
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
    if(delReqDate != null && delReqDate != ""){
      return ":${convertTimestampToDateString(delReqDate)}";
    }else{
      return "";
    }

  }


}
setAddress(myOrderList, String s) {
  log(myOrderList.toString());
  log(s.toString());
  if(myOrderList != null){
    return myOrderList[s].toString();
  }else {
    return "";
  }
}