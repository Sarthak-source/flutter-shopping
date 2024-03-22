import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
          Padding(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(20),
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                List invoicePaymentList = notificationController.notification;
                return invoicePaymentList.isEmpty
                    ? _buildShimmerLoading()
                    : ListView.builder(
                        itemCount: invoicePaymentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final payment = invoicePaymentList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            child: Container(
                              height: 90,
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Invoice: $payment',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
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
