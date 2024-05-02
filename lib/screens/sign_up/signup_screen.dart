import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/login_controller.dart';
import '../../utils/StateDropDown.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/back_button_ls.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/option_button.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signupScreen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Map<String, dynamic>? selectedState;
  final LoginController loginController = Get.put(LoginController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedStateId = "";
  @override
  Widget build(BuildContext context) {
    // final LoginController loginController = Get.find();
    //  print("ssss${loginController.stateList.length}");
    ScreenUtils().init(context);
    return GetBuilder<LoginController>(builder: (ctrlr) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonLS(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Sign Up To Continue!',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomTextField(
                          controller: nameController,
                          hint: 'Your Name',
                          TextInputType: TextInputType.text),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kGreyShade3),
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(15),
                                  )),
                              child: const Center(child: Text("+91")),
                            ),

                            /*    child: CustomTextField(
                                hint: '+91',

                                  TextInputType: TextInputType.number
                              ),*/
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomTextField(
                                controller: phoneController,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)], // Add inputFormatters to limit to digits and length
                                hint: 'Phone Number',
                                validator: (value) {
                                  if (value!.length != 10 || value.isEmpty) {
                                    return 'Please enter a valid number';
                                  }
                                  return null; // Return null if input is valid
                                },
                                TextInputType: TextInputType.number),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      StateDropdown(
                        hinttxt: "Select State",
                        devicewidth: Get.width / 2 + 10,
                        selectedValue: selectedState,
                        //  options: ["Select State","Tamil Nadu","Kerala","Karnataka"],
                        options: ctrlr.stateList,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedState = value;
                              print(
                                  "selected state :: ${selectedState?["name"]} ${selectedState?["id"]}");
                              selectedStateId =
                                  selectedState?["id"].toString() ?? "";
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          print(
                              'signup param\n name: ${nameController.text}\n num: ${phoneController.text} \n stateId:${selectedStateId}');

                          loginController.signUp(nameController.text,
                              phoneController.text, selectedStateId);
                        },
                        child: const Text('Sign Up'),
                      ),
                      const Spacer(),
                      OptionButton(
                        desc: 'Have an account? ',
                        method: 'Login',
                        onPressHandler: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
