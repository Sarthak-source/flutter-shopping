// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/login_controller.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
      () => 'Your code is 54321',
    );
  }
}

class OtpScreenArguments {
  final String phoneNumber;

  OtpScreenArguments({required this.phoneNumber});
}

class OtpScreen extends StatefulWidget {
  static const routeName = '/otpScreen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int countdown = 30;
  late Timer timer;
  bool isLoadingButton = false;
  bool showOtp = false;
  TextEditingController otpController = TextEditingController(text: "");
  LoginController loginController = LoginController();
  late OTPTextEditController otpTextEditController;
  final otpFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startCountdown();
    if (Platform.isAndroid) {
      _startListeningForOtp();
    }
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _startListeningForOtp() {
    otpTextEditController = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) {
        setState(() {
          otpFieldController.text = code;
        });
        loginController.verifyOtpCode(
            ModalRoute.of(context)?.settings.arguments as OtpScreenArguments,
            otpController,
            context,
            null,
            null,
            null,
            null);
      },
    )..startListenUserConsent(
        (code) {
          return RegExp(r'\d{4}').stringMatch(code ?? '') ?? '';
        },
        strategies: [
          SampleStrategy(),
        ],
      );
  }

  @override
  void dispose() {
    timer.cancel();
    otpTextEditController.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as OtpScreenArguments;
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          height: Get.height / 2 + 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(80),
              ),
              Text(
                'Enter OTP',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: getProportionateScreenWidth(23),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 16.0,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'We have sent verification code\nto ',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.grey,
                                fontSize: getProportionateScreenWidth(20),
                              ),
                    ),
                    TextSpan(
                      text: '+91-${args.phoneNumber}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: kPrimaryBlue,
                                fontSize: getProportionateScreenWidth(16),
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OtpTextField(
                numberOfFields: 4,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                fillColor: const Color.fromARGB(255, 233, 233, 233),
                borderWidth: 1,
                filled: true,
                textStyle: const TextStyle(fontSize: 20),
                focusedBorderColor: kPrimaryBlue,
                fieldWidth: 60,
                margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  otpController.text = verificationCode;
                  loginController.verifyOtpCode(
                      args, otpController, context, null, null, null, null);
                  //Get.toNamed(TabScreen.routeName);
                }, // end onSubmit
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Did not receive code?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: getProportionateScreenWidth(14),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 16.0,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Please wait..   ',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: getProportionateScreenWidth(16),
                              ),
                    ),
                    TextSpan(
                      text: countdown > 0 ? '$countdown' : 'done',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: getProportionateScreenWidth(14),
                              color: kPrimaryBlue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  //_onClickRetry(args);
                },
                child: const Text(
                  'resend OTP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
