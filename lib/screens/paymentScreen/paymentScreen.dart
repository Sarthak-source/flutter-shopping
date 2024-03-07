import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/payment_controller.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/addPayemntDetail.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class Payment {
  final String invoice;
  final double amount;
  final String paymentType;
  final String date;

  Payment({
    required this.invoice,
    required this.amount,
    required this.paymentType,
    required this.date,
  });
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Define a list of payment details using the Payment class
  final List<Payment> payments = [
    Payment(
      invoice: 'Invoice 1',
      amount: 100.0,
      paymentType: 'Cash',
      date: '12/09/2024',
    ),
    Payment(
      invoice: 'Invoice 2',
      amount: 150.0,
      paymentType: 'Credit Card',
      date: '12/09/2024',
    ),
    // Add more payment details as needed
  ];

   final PaymentController paymentController =
        Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Obx(
             () {
            List paymentsList=  paymentController.payment;
            log(paymentsList.toString());
              return Expanded(
                child: ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final payment = payments[index];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
                                  Text(payment.invoice),
                                  const Spacer(),
                                  //Text('Payment Type: ${payment.paymentType}'),
                                ],
                              ),
                              const Spacer(),
                               Row(
                                 children: [
                                   Text(
                                          payment.date),
                                          const Spacer(),
                                  Text('Payment Type: ${payment.paymentType}'),
                                 ],
                               ),
                               const Spacer(),
                              Row(
                                children: [
                                  Text(
                                      'Amount: ${payment.amount.toStringAsFixed(2)}'),
                                  const Spacer(),
                                  // Check if date is not null before displaying
                                 
                                ],
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
          ),
        ],
      ),
    );
  }
}
