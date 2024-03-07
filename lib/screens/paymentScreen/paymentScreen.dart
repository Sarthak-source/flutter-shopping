import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import 'addPayemntDetail.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPaymentPage()));
            },
            backgroundColor: kPrimaryBlue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
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
                Row(
                  children: [
                    Text(
                      'Payment Details',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(
                          20,
                        ),
                      ),
                    ),


                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
