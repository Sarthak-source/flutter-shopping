import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../config/common.dart';
import '../../controllers/payment_controller.dart';
import '../../utils/common_functions.dart';

class PendingPayment extends StatefulWidget {
  static const routeName = '/signUpSuccess';

  const PendingPayment({super.key});

  @override
  State<PendingPayment> createState() => _PendingPaymentState();
}

class _PendingPaymentState extends State<PendingPayment> {
  final PaymentController controller = Get.put(PaymentController());
String? pendingAmnt="";
  @override
  void initState() {
     super.initState();



  }

  @override
  Widget build(BuildContext context) {
    pendingAmnt= controller.pendingPayment.value;
    return Scaffold(
      body: Obx(()=>

         Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lotties/closeAnim.json',
                    repeat: false,
                    height: getProportionateScreenHeight(200.0),
                    width: getProportionateScreenWidth(200.0),
                  ),

                  Text(
                    'Total Pending Amount :    ₹ ${ twodecimalDigit(double.parse( controller.pendingPayment.value==null?"0.000":controller.pendingPayment.value.toString()))}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10.0),
                    ),
                    child: Text(
                      'New Order Placement Is Not Allowed.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                       // color: kTextColorAccent,
                        color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 19
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
