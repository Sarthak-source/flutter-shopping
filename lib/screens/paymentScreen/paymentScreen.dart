import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/payment_controller.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/addPayemntDetail.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimaryBlueTest2,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPaymentPage()),
            );
          },
          backgroundColor: kPrimaryBlue,
          label: const Text(
            'Add Payment',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
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
                  height: 18,
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
                List paymentsList = paymentController.payment;
                return ListView.builder(
                  itemCount: paymentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final payment = paymentsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(
                              8,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Invoice: ${payment['invoice']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Payment Type: ${payment['payment_mode']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(payment['payment_date']))}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Amount: ${payment['amount']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
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
