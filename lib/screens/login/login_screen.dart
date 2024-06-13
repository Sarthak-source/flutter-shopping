import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/assets/logo.dart';
import 'package:sutra_ecommerce/config/common.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';
import 'package:sutra_ecommerce/controllers/login_controller.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/screens/sign_up/signup_screen.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/loader.dart';
import '../../widgets/option_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController(text: '');
  //LoginController loginController = LoginController();
  final LoginController loginController = Get.put(LoginController());
  final commonController = Get.put(CommonController());

  //final UserController userController = Get.put(UserController());
  bool repeat = false;

  @override
  void initState() {
    // log(box!.get('userData').toString());
    // userController.user.value={};
    // log(userController.user.value.toString());

    box!.delete('userData');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);

    // void handlePhoneNumberChange(String value) {
    //   setState(() {
    //     phoneNumber.value = value;

    //     // Check if the entered text is a 10-digit number
    //     if (phoneNumber.length == 10 && int.tryParse(phoneNumber) != null) {
    //       // Run your function here
    //       log('Function triggered with phone number: $phoneNumber');
    //       Get.toNamed(TabScreen.routeName);
    //     }
    //   });
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const BackButtonLS(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Transform.translate(
                        offset: const Offset(-70, -50),
                        child: Transform.scale(
                            scale: 0.30, child: const BouncingLogo())),
                    SizedBox(
                      height: getProportionateScreenHeight(60),
                    ),
                    Row(
                      children: [
                        Text(
                          'Log In To Continue!',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomTextField(
                      hint: 'Phone number',
                      controller: phoneNumberController,
                      TextInputType: TextInputType.number,
                      //onChanged: handlePhoneNumberChange,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Obx(
                      () => SizedBox(
                        width: getProportionateScreenHeight(Get.width),
                        child: loginController.isLoading.value
                            ? const Loader()
                            : ElevatedButton(
                                onPressed: () {
                                  String phoneNumber =
                                      phoneNumberController.text;

                                  //Get.toNamed(TabScreen.routeName);

                                  if (phoneNumber.length < 10 ||
                                      phoneNumber.length > 10) {
                                    // Handle the case where the phone number is too shrort
                                    Fluttertoast.showToast(
                                      msg: 'Enter a proper number',
                                      backgroundColor: Colors.red,
                                    );
                                  } else {
                                    log(phoneNumber);
                                    commonController.commonCurTab.value = 0;
                                    loginController.userExists(phoneNumber);
                                    loginController.update();
                                  }
                                },
                                child: const Text('Continue'),
                              ),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    OptionButton(
                      desc: 'Don\'t have an account? ',
                      method: 'Sign Up',
                      onPressHandler: () {
                        loginController.getStates();

                        Get.toNamed(SignupScreen.routeName,
                            arguments: OtpScreenArguments(
                                phoneNumber: phoneNumberController.text));
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingLogo extends StatefulWidget {
  const BouncingLogo({super.key});

  @override
  BouncingLogoState createState() => BouncingLogoState();
}

class BouncingLogoState extends State<BouncingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    );

    _controller.forward(); // Play the animation forward only once
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.6 + _animation.value * 0.2,
          child: CustomPaint(
            size: const Size(118, 117),
            painter: Logo(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
