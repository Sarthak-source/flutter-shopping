import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sutra_ecommerce/screens/paymentScreen/upi_screen.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';

class EnterAmount extends StatefulWidget {
  String? paymentType;
   EnterAmount({super.key,this.paymentType});

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Payment Amount',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomTextField(
                controller: amountController,
                hint: 'Enter amount',
                TextInputType: TextInputType.number
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
            ),
            child: ElevatedButton(
              onPressed: () {
               // Get.toNamed(FlutterPayUPI.routeName);
                if(amountController.text == null || amountController.text ==""){
                  Fluttertoast.showToast(
                    msg: 'Enter Amount',
                    backgroundColor: Colors.red,
                  );
                }else{
                  if(widget.paymentType == "upi"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>FlutterPayUPI(paymentAmount: amountController.text,)));
                  }else{

                  }
                }


              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
