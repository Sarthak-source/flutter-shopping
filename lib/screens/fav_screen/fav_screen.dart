import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import '../../constants/colors.dart';
import '../../controllers/my_order_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/tab_title.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final CommonController cmncontroller = Get.put(CommonController());
  final MyOrderController myOrderController = Get.put(MyOrderController());



@override
  void initState() {
    super.initState();
    myOrderController.selectedBtn.value = 1;
    myOrderController.myOrderList.clear();
    myOrderController.getMyOrders("Approved","1");
    myOrderController.update();
}
  @override
  Widget build(BuildContext context) {


    return Obx(()=>
       Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  children: [Container()],
              children: [
                SizedBox(height: 20,),
                Text(
                  'My Favourites',
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
                SizedBox(height: 20,),
                TabTitle(
                    title: "Recent Orders",
                    seeAll: () {
                      // Get.toNamed(CategoryScreen.routeName);
                    }),
            Container(
             height: 365,
             width: Get.width,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: myOrderController.myOrderList.length,
                //  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                          decoration: BoxDecoration(
                            color: kPrimaryBoxBG,
                              borderRadius: BorderRadius.circular(16)),
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                                          gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          ),
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context, int index) {

                          return
                            index == 3? Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                    child: Center(
                                      child: Text("+7",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                                    ),
                                    ),
                                  ),
                                )):
                            Container(
                            margin: const EdgeInsets.all(4.0),
                            // color: Colors.blue[100 * (index % 9)],
                            //  color: Colors.blue[100 * (1 % 9)],

                            decoration: BoxDecoration(
                                color: Colors.white,
                               // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  color: Colors.white,
                                  child: Image.network(
                                      'http://170.187.232.148/static/images/dilicia.png'),
                              ),
                            ),
                          ));
                                          },
                                        ),
                        ),
                      ),
                      Container(
                        height: 110,
                        width: 205,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12,),
                              Text(convertTimestampToDateString(
                                  myOrderController.myOrderList[index]["order_date"].toString()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              SizedBox(height: 8,),
                              Text("${ myOrderController.myOrderList[index]["order_items"].length} products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey)),
                              //SizedBox(height: 18,),
                              Container(
                                height: 49,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                    child: const Text(
                                      'Reorder',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),

            Column(
                children: [
                        const SizedBox(
                        height: 18,
                      ),
                        Row(
            children: [

              // const Icon(
              //   Icons.search,
              //   color: kPrimaryBlue,
              // ),
            ],
                        ),
                        SizedBox(
            height: getProportionateScreenHeight(16.0),
                        ),
                        Lottie.asset('assets/lotties/cart.json',
              repeat: false,
              height: getProportionateScreenHeight(250.0),
              width: getProportionateScreenWidth(250.0)),
                        SizedBox(
            height: getProportionateScreenHeight(10.0),
                        ),

                        Text(
            'Oops Your Wishlist Is Empty',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
                        ),
                        SizedBox(
            height: getProportionateScreenHeight(16.0),
                        ),
                        Text(
            'It seems noting in here. Explore more and shortlist some items',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: kTextColorAccent,
            ),
                        ),
                        SizedBox(
            height: getProportionateScreenHeight(16.0),
                        ),
                        ElevatedButton(
            onPressed: () {
              cmncontroller.commonCurTab.value = 0;
              cmncontroller.update();
            },
            child: const Text(
              'Start Shopping',
            ),
                        ),
                        SizedBox(
            height: getProportionateScreenHeight(16.0),
                        ),

                        ]),

              ],
            ),
          )),
    );
  }
}
