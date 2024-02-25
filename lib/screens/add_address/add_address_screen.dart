import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/add_address_controller.dart';
import 'package:sutra_ecommerce/screens/add_address/post_address.dart';

import '../../constants/colors.dart';
import '../../controllers/mycart_controller.dart';
import '../../utils/screen_utils.dart';
import '../../utils/shimmer_placeholders/myorder_shimmer.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/loading_widgets/loader.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add_address_screen';

  AddAddressScreen({super.key});

  final AddAddressController controller = Get.put(AddAddressController());
  final MyCartController createOrderCtlr = Get.put(MyCartController());

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<MyCartController>(builder: (createOrderCtlr) {
      return GetBuilder<AddAddressController>(builder: (controller) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostAddressPage()));
                },
                backgroundColor: kPrimaryBlue,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
          body: SafeArea(
            child:   controller.isLoading.value
                ?
            Center(child: Loader())
             /* Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
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
                                    child: MyOrderShimmer(from: "addAddress"),
                                  );
                                },
                              ),
                            ),
                          )*/
                : controller.hasError.value
                ? Text('Error: ${controller.errorMsg.value}')
                :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BackButtonLS(),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Add Your Address',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(17),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.myAddressItems.isEmpty?Expanded(
                  child: Container(
                    width: Get.width,
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lotties/no-data.json',
                            repeat: false,
                            height: getProportionateScreenHeight(250.0),
                            width: getProportionateScreenWidth(250.0)),
                        SizedBox(height: getProportionateScreenHeight(10.0)),
                        const Text(
                          'No Address Found',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: kPrimaryBlue),
                        ),
                      ],
                    ),
                  ),
                ):
                Expanded(
                  child: SingleChildScrollView(
                    child:  ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.myAddressItems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  log('controller.myAddressItems lg.... ${controller.myAddressItems.length}');

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.slectedIndex = RxInt(index);
                                        controller.update();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: controller
                                                          .slectedIndex.value ==
                                                      index
                                                  ? kPrimaryBlue
                                                  : Colors.white,
                                            )
                                            // color:controller.slectedIndex==index?kPrimaryBlue.withOpacity(0.2) :Colors.white,
                                            ),
                                        child: ListTile(
                                          title: Text(
                                            controller.myAddressItems[index]
                                                ["address_line1"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          14),
                                                ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  controller
                                                          .myAddressItems[index]
                                                      ["address_line2"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                11),
                                                      )),
                                              Text(
                                                  controller
                                                          .myAddressItems[index]
                                                      ["address_line3"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                11),
                                                      )),
                                              Text(
                                                  "GST : ${controller.myAddressItems[index]["gstin"]["gstin"]}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                11),
                                                      )),
                                              // const Divider(),
                                            ],
                                          ),
                                          leading: const Icon(
                                            Icons.location_on_outlined,
                                            size: 30,
                                            color: kPrimaryBlue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                  ),
                ),
                createOrderCtlr.isLoading.value? Center(child: Loader()):    Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(16.0),
                    horizontal: getProportionateScreenWidth(16.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      String address =
                          "${controller.myAddressItems[controller.slectedIndex.toInt()]["id"]}";
                      log('selected address: $address');
                      createOrderCtlr.createOrderApi(
                          "1", "1", "2015-01-28 03:00:00", address);
                      // Get.toNamed(OrderSuccessScreen.routeName);
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
