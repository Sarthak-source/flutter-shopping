import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/enterAmount.dart';

import '../../controllers/payment_controller.dart';
import '../../utils/circularCheckbox_text.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});
  static const routeName = '/selectPaymentMethod';
  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final PaymentController controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenWidth(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BackButtonLS(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(17),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            Container(
            //  color: Colors.red,
              width:Get.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularCheckBoxWithText(
                      text: 'COD',
                      initialValue: controller.cod.value,
                      onChanged: (value) {
                        // Do something with the value
                        print('Checkbox COD: $value');
                        setState(() {
                          if(value == true){
                            controller.cod.value = value;
                            controller.upi.value = false;
                            controller.update();
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>EnterAmount(paymentType: "cod",)));
                          }else{
                            controller.cod.value = value;
                            controller.upi.value = true;
                            controller.update();
                           // upi = true;
                          }

                        });

                      },
                    ),
                    const SizedBox(height: 50),
                    CircularCheckBoxWithText(
                      text: 'UPI',
                      initialValue: controller.upi.value,
                      onChanged: (value) {
                        // Do something with the value
                        setState(() {


                          if(value == true){
                            controller.upi.value = value;
                            controller.cod.value = false;
                            controller.update();
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>EnterAmount(paymentType: "upi",)));
                          }else{
                            controller.upi.value = value;
                            controller.cod.value = true;
                            controller.update();
                          //  cod = true;
                          }
                        });
                        print('Checkbox UPI: $value');
                      },
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
