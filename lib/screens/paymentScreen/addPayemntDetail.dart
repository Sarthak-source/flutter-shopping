import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/payment_controller.dart';

import '../../constants/colors.dart';
import '../../utils/StateDropDown.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/loader.dart';

class AddPaymentPage extends StatefulWidget {
  static const routeName = '/post_payment_screen';
  const AddPaymentPage({super.key});

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  Map<String, dynamic>? selectedState;
  RxList invoicelist = [
    {"name": "invoice1"},
    {"name": "invoice2"},
    {"name": "invoice3"}
  ].obs;
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PaymentController controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Scaffold(
        body: Obx(
          () => SafeArea(
            child: controller.isLoading.value
                ? const Loader()
                : Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      'Add Payment Details',
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(17),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Select Invoice",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: kTextColorAccent,
                                    )),
                            StateDropdown(
                              hinttxt: "",
                              devicewidth: Get.width / 2 + 10,
                              selectedValue: selectedState,
                              options: invoicelist,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedState = value;
                                    print(
                                        "selected state :: ${selectedState?["name"]}");
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Amount",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: kTextColorAccent,
                                    )),
                            const CustomTextField(
                                // controller: nameController,
                                hint: '',
                                TextInputType: TextInputType.text),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(16.0),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.addPayments(
                                        invoice: 'invoice',
                                        amount: 'amount',
                                        paymentMode: 'paymentMode',
                                        paymentDate: 'paymentDate',
                                        collectedBy: 'collectedBy');
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
