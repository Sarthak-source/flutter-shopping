import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/notification_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../widgets/custom_app_bar.dart';

class Notification extends StatefulWidget {
  static const routeName = '/notification';

  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,title: const Text('Notifications'),),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 80.0),
      //   child: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => const AddPaymentPage()),
      //       );
      //     },
      //     backgroundColor: kPrimaryBlue,
      //     label: const Text(
      //       'Add Payment',
      //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //     ),
      //     icon: const Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const CustomAppBar(
            marginBottom: 12,
            actions: [],
            title: 'Notifications',
          ),
          Expanded(
            child: Obx(
              () {
                List invoicePaymentList = notificationController.notification;
                return notificationController.isLoading.value
                    ? _buildShimmerLoading()
                    : invoicePaymentList.isEmpty
                        ? const Center(child: Text("No Notification Found"))
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 0.4,
                              );
                            },
                            itemCount: invoicePaymentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final payment = invoicePaymentList[index];
                              log(payment.toString());

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                child: SizedBox(
                                  height: 65,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                'Paid Rs ${payment['amount_paid'] == null ? "" : payment['amount_paid'].toString()} against invoice no ${payment['invoice'] ?? ""}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 30,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 91, 83, 255),
                                                    side: const BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 91, 83, 255)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    //print('notify id: ${payment["id"]}');
                                                    notificationController
                                                        .setStatusNotification(
                                                            "Confirm",
                                                            payment["id"]
                                                                    .toString() ??
                                                                "");
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(width: 10,),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 30,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 244, 54, 114),
                                                    side: const BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 244, 54, 114)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    notificationController
                                                        .setStatusNotification(
                                                            "Declined",
                                                            payment["id"].toString() ??
                                                                "");
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            /*      Flexible(

                                          child: SizedBox(
                                            height: 30,
                                           // width: 180,
                                            child: Row(
                                              children: [

                                              ],
                                            ),
                                          ),
                                        ),*/

                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['id'].toString()}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['amount_paid']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['payment_mode']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['payment_date']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['confirmation_status']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['invoice']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                            // Flexible(
                                            //   child: Text(
                                            //     '${payment['collected_by']}',
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildShimmerLoading() {
  return ListView.builder(
    itemCount: 5, // Placeholder count
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(8),
              ),
            ),
          ),
        ),
      );
    },
  );
}
