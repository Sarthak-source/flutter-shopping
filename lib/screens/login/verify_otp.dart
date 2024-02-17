// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/screens/tab_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
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
  bool _isLoadingButton = false;
  TextEditingController otpController = TextEditingController(text: "");
  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    startCountdown();
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _verifyOtpCode(OtpScreenArguments args) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoadingButton = false;
    });

    if (otpController.text.isNotEmpty) {
      try {
        Get.toNamed(TabScreen.routeName);
        // var value = await networkRepository.verifyLogin(
        //   number: args.phoneNumber,
        //   otp: otpController.text,
        // );

        // //log(value.toString());

        // if (value["type"].toString() == "error") {
        //   Fluttertoast.showToast(msg: 'wrong OTP');
        //   otpController.clear();
        // } else {
        //   Future.delayed(Duration.zero, () async {
        //     try {
        //       //await sendFCMAndLocation();
        //     } catch (e) {
        //       Fluttertoast.showToast(msg: e.toString());
        //     }
        //   });

        //   box!.put("login", true);
        //   if (!context.mounted) return;
        //   Get.toNamed(TabScreen.routeName);
        // }
      } catch (error) {
        Fluttertoast.showToast(msg: 'Error verifying OTP');
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as OtpScreenArguments;
    return Scaffold(
      //appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(80),
          ),
          const Text(
            'Enter OTP',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 16.0, // Set the font size to 14
                  ),
              children: <TextSpan>[
                const TextSpan(
                  text: 'We have sent verification code\nto ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none, // Remove underline
                  ),
                ),
                TextSpan(
                  text: '+91-${args.phoneNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kPrimaryBlue,
                    decoration: TextDecoration.none, // Remove underline
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //ElevatedButton(onPressed: (){}, child: Text('data')),
          OtpTextField(
            numberOfFields: 4,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            fillColor: const Color.fromARGB(255, 233, 233, 233),

            borderWidth: 1,
            filled: true,

            focusedBorderColor: kPrimaryBlue,
            fieldWidth: 60,
            margin: const EdgeInsets.only(right: 10.0, left: 10.0),
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              otpController.text = verificationCode;
              _verifyOtpCode(args);
              //Get.toNamed(TabScreen.routeName);
            }, // end onSubmit
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Did not receive code?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 16.0, // Set the font size to 14
                  ),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Please wait..   ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    decoration: TextDecoration.none, // Remove underline
                  ),
                ),
                TextSpan(
                  text: countdown > 0 ? '$countdown' : 'done',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryBlue,
                    decoration: TextDecoration.none, // Remove underline
                  ),
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
    );
  }
}
