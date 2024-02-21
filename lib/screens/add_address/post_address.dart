import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../controllers/add_address_controller.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/common_textfield_withicon.dart';
import '../../widgets/loading_widgets/loader.dart';

class PostAddressPage extends StatefulWidget {
  const PostAddressPage({super.key});

  @override
  State<PostAddressPage> createState() => _PostAddressPageState();
}

class _PostAddressPageState extends State<PostAddressPage> {

  TextEditingController addressl1controller = TextEditingController();
  TextEditingController addressl2controller = TextEditingController();
  TextEditingController addressl3controller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AddAddressController controller = Get.put(AddAddressController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(
      builder: (controller){
     return Scaffold(
        body: SafeArea(
          child: Form(
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
                              'Add Your Address',
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

                    Text("Address Line 1", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    )),
                    Container(
                      height: 50,
                      child: CustomTextFieldicon(
                          textInputType: TextInputType.name,
                          txtalign: TextAlign.left,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          labelicon: Icons.home_outlined,
                          hintText: '',
                          controller: addressl1controller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Address Line 2", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    )),
                    Container(
                      height: 50,
                      child: CustomTextFieldicon(
                          textInputType: TextInputType.name,
                          txtalign: TextAlign.left,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          labelicon: Icons.home_outlined,
                          hintText: '',
                          controller: addressl2controller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Address Line 3", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    )),
                    Container(
                      height: 50,
                      child: CustomTextFieldicon(
                          textInputType: TextInputType.name,
                          txtalign: TextAlign.left,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          labelicon: Icons.home_outlined,
                          hintText: '',
                          controller: addressl3controller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Pincode", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    )),
                    Container(
                      height: 50,
                      child: CustomTextFieldicon(
                          textInputType: TextInputType.name,
                          txtalign: TextAlign.left,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter pincode';
                            }
                            return null;
                          },
                          labelicon: Icons.home_outlined,
                          hintText: '',
                          controller: pincodecontroller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("GST", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColorAccent,
                    )),
                    Container(
                      height: 50,
                      child: CustomTextFieldicon(
                          textInputType: TextInputType.name,
                          txtalign: TextAlign.left,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter GST';
                            }
                            return null;
                          },
                          labelicon: Icons.home_outlined,
                          hintText: '',
                          controller: gstcontroller),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    controller.isLoading.value?const Loader():  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(
                                'address 1 : ${addressl1controller.text}\n address 2: ${addressl2controller.text}\n address 3: ${addressl3controller.text}\n pincode: ${pincodecontroller.text}\n gst: ${gstcontroller.text}');
                            controller.addNewAddress(addressl1controller.text,addressl2controller.text,addressl3controller.text,pincodecontroller.text,gstcontroller.text);
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
      );}
    );
  }
}
