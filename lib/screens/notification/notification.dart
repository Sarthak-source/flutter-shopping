import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/notification_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

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
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,title: const Text('Notifications'),),
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
          Expanded(
            child: Obx(
              () {
                List invoicePaymentList = notificationController.notification;
                return invoicePaymentList.isEmpty
                    ? _buildShimmerLoading()
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              'Paid Rs ${payment['amount_paid'].toString()} against invoice no ${payment['invoice']}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),

                                          Flexible(
                                            child: SizedBox(
                                              height: 30,
                                              width: 180,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        
                                                        side: const BorderSide(
                                                            color:
                                                                kPrimaryBlue),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        // Add your action for the first button
                                                      },
                                                      child: const Text(
                                                        'Confirm',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Expanded(
                                                    flex: 1,
                                                    child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                            
                                                        
                                                        side: const BorderSide(
                                                            color: Colors.red),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        // Add your action for the second button
                                                      },
                                                      child: const Text(
                                                        'Decline',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

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
