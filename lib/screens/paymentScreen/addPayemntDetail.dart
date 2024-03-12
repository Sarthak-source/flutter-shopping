import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/payment_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/loader.dart';

class AddPaymentPage extends StatefulWidget {
  static const routeName = '/post_payment_screen';
  const AddPaymentPage({Key? key}) : super(key: key);

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
  TextEditingController paymentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PaymentController controller = Get.put(PaymentController());

  final UserController userController = Get.put(UserController());
  String? selectedPaymentMode;

  Map? selectedInvoice;

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      Map paymentModes = userController.partyConfig['payment_mode'] as Map;

      RxList paymentsOptionList = paymentModes.values.toList().obs;

      selectedPaymentMode = paymentsOptionList[0];

      selectedInvoice = controller.invoicesList[0];

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

                            //Text(controller.invoicesList.toString()),

                            // Text("Select Invoice",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headlineMedium!
                            //         .copyWith(
                            //           color: kTextColorAccent,
                            //         )),
                            // StateDropdown(
                            //   hinttxt: "",
                            //   devicewidth: Get.width / 2 + 10,
                            //   selectedValue: selectedState,
                            //   options: invoicelist,
                            //   onChanged: (value) {
                            //     if (value != null) {
                            //       setState(() {
                            //         selectedState = value;
                            //         print(
                            //             "selected state :: ${selectedState?["name"]}");
                            //       });
                            //     }
                            //   },
                            // ),
                            const SizedBox(
                              height: 20,
                            ),

                            // StateDropdown(
                            //   hinttxt: "",
                            //   devicewidth: Get.width / 2 + 10,
                            //   selectedValue: selectedPaymentMode,
                            //   options: paymentsOptionList,
                            //   onChanged: (value) {
                            //     if (value != null) {
                            //       setState(() {
                            //         selectedState = value;
                            //         print(
                            //             "selected state :: ${selectedState?["name"]}");
                            //       });
                            //     }
                            //   },
                            // ),
                            Text("Select Payments",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: kTextColorAccent,
                                    )),
                            Container(
                              height: 60,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kGreyShade3),
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(15),
                                  )),
                              child: Center(
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Colors.transparent,
                                  ),
                                  value: selectedPaymentMode,
                                  hint: const Text('Select Payment Mode'),
                                  items: paymentsOptionList.map((mode) {
                                    return DropdownMenuItem<String>(
                                      value: mode,
                                      child: Text(mode),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentMode = value!;
                                      print(
                                          "Selected Payment Mode: $selectedPaymentMode");
                                    });
                                  },
                                ),
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

                            Container(
                              height: 60,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: kGreyShade3),
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(15),
                                ),
                              ),
                              child: Center(
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Colors.transparent,
                                  ),
                                  value: selectedInvoice?["id"]
                                      .toString(), // Assuming 'id' is a unique identifier for each invoice
                                  hint: const Text('Select Invoice'),
                                  items: controller.invoicesList.map((invoice) {
                                    return DropdownMenuItem<String>(
                                      value: invoice["id"]
                                          .toString(), // Use the unique identifier as the value
                                      child: Text(
                                          'Invoice ${invoice["id"]}'), // You can customize the display text as per your requirement
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      // Find the selected invoice from the list based on the selected value
                                      selectedInvoice = controller.invoicesList
                                          .firstWhere((invoice) =>
                                              invoice["id"].toString() ==
                                              value);
                                      print(
                                          "Selected Invoice: $selectedInvoice");
                                    });
                                  },
                                ),
                              ),
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
                             CustomTextField(
                                 controller: paymentController,
                                hint: '',
                                TextInputType: TextInputType.text),
                            const SizedBox(
                              height: 20,
                            ),

                            //Text(selectedInvoice.toString()),
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
                                        invoice: selectedInvoice!['invoice'].toString(),
                                        amount: paymentController.text,
                                        paymentMode: selectedPaymentMode!,
                                        paymentDate: DateTime.now().toString(),
                                        collectedBy: '1', status: 'Created');
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
