import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../controllers/add_address_controller.dart';
import '../../utils/StateDropDown.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/common_textfield_withicon.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/loader.dart';

class AddPaymentPage extends StatefulWidget {
  static const routeName = '/post_payment_screen';
  const AddPaymentPage({super.key});

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {

  Map<String,dynamic>? selectedState ;
  RxList invoicelist = [
    {"name":"invoice1"},{"name":"invoice2"},{"name":"invoice3"}].obs;
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AddAddressController controller = Get.put(AddAddressController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(
        builder: (controller){
          return Scaffold(
            body: Obx(()=>
                SafeArea(
                  child: controller.isLoading.value?const Loader():Form(
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
                                        fontSize: getProportionateScreenWidth(17),
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
                            Text("Select Invoice", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: kTextColorAccent,
                            )),
                            StateDropdown(
                              hinttxt: "",
                              devicewidth: Get.width / 2 + 10,
                              selectedValue: selectedState,
                                options: invoicelist,

                              onChanged: (value) {
                                if(value != null){
                                  setState(() {
                                    selectedState = value;
                                    print("selected state :: ${selectedState?["name"]}");

                                  });
                                }

                              },
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            Text("Amount", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: kTextColorAccent,
                            )),

                            CustomTextField(
                               // controller: nameController,
                                hint: '',
                                TextInputType: TextInputType.text
                            ),
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
          );}
    );
  }
}
