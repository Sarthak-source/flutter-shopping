// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

class OtpScreenArguments {
  final String phoneNumber;

  OtpScreenArguments({required this.phoneNumber});
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int countdown = 30;
  late Timer timer;
  bool _isLoadingButton = false;
  TextEditingController otpController = TextEditingController(text: "");

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

  _onSubmitOtp(OtpScreenArguments args) {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      if (kIsWeb) {
        _verifyOtpCodeWeb(args);
      } else {
        _verifyOtpCode(args);
      }
    });
  }

  _onClickRetry(OtpScreenArguments args) async {
    otpController.clear();
    // var response = await networkRepository.retry(number: args.phoneNumber);
    // Fluttertoast.showToast(
    //     msg: response['body'], backgroundColor: Colors.green);
  }

  // Future<LocationData?> getLocation() async {
  //   Location location = Location();
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;
  //   serviceEnabled = await location.serviceEnabled();

  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return null;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();

  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  //   locationData = await location.getLocation();

  //   return locationData;
  // }

  // Future<void> sendFCMAndLocation() async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();

  //   AndroidDeviceInfo? deviceInfo;
  //   IosDeviceInfo? iosDeviceInfo;
  //   if (Platform.isIOS) iosDeviceInfo = await deviceInfoPlugin.iosInfo;
  //   if (Platform.isAndroid) deviceInfo = await deviceInfoPlugin.androidInfo;
  //   if (!context.mounted) return;
  //   final userModel = Provider.of<UserModel>(context, listen: false).userData;

  //   LocationData? locationData;
  //   try {
  //     locationData = await getLocation();
  //   } catch (e) {
  //     log('Error getting location: $e');
  //     locationData = LocationData.fromMap({});
  //   }

  //   String? token;
  //   try {
  //     token = await messaging.getToken();
  //   } catch (e) {
  //     log('Error getting FCM token: $e');
  //     token = 'no token';
  //   }

  //   if (token != null) {
  //     double latitude = locationData?.latitude ?? 0.0;
  //     double longitude = locationData?.longitude ?? 0.0;

  //     await networkRepository.postLatLng(
  //       member: userModel['id'].toString(),
  //       lat: latitude.toString(),
  //       lng: longitude.toString(),
  //     );

  //     try {
  //       await networkRepository.postFCM(
  //         fcmToken: token,
  //         member: userModel['id'].toString(),
  //         phoneMac: Platform.isAndroid
  //             ? deviceInfo!.fingerprint.toString()
  //             : iosDeviceInfo?.identifierForVendor.toString() ?? 'no token',
  //       );
  //     } catch (e) {
  //       Fluttertoast.showToast(msg: 'Error posting FCM');
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: 'Error posting FCM');
  //   }
  // }

  // _verifyOtpCode(OtpScreenArguments args) async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   setState(() {
  //     _isLoadingButton = false;
  //   });

  //   if (otpController.text.isNotEmpty) {
  //     try {
  //       var value = await networkRepository.verifyLogin(
  //         number: args.phoneNumber,
  //         otp: otpController.text,
  //       );

  //       if (value["type"].toString() == "error") {
  //         Fluttertoast.showToast(msg: wrongOTP);
  //         otpController.clear();
  //       } else {
  //         Future.delayed(Duration.zero, () async {
  //           try {
  //             await sendFCMAndLocation();
  //           } catch (e) {
  //             Fluttertoast.showToast(msg: e.toString());
  //           }
  //         });

  //         box!.put("login", true);
  //         if (!context.mounted) return;
  //         Navigator.pushReplacementNamed(context, '/dashboard');
  //       }
  //     } catch (error) {
  //       Fluttertoast.showToast(msg: 'Error verifying OTP');
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: enterOTP);
  //   }
  // }

//   _verifyOtpCode() async {
//     final deviceInfoPlugin = DeviceInfoPlugin();
//     AndroidDeviceInfo? deviceInfo;
//     IosDeviceInfo? iosDeviceInfo;
//     if (Platform.isIOS) iosDeviceInfo = await deviceInfoPlugin.iosInfo;
//     if (Platform.isAndroid) deviceInfo = await deviceInfoPlugin.androidInfo;
//     if (!context.mounted) return;
//     FocusScope.of(context).requestFocus(FocusNode());
//     final userModel = Provider.of<UserModel>(context, listen: false).userData;
//     setState(() {
//       _isLoadingButton = false;
//     });
//     if (otpController.text.isNotEmpty) {
//       String? token = await messaging.getToken();

//       log("token here go $token");

//       // String? token = "testtoken";
//       log("spaekaer ${widget.phoneNumber}");
//       log("spaekaer ${otpController.text}");

//       await networkRepository
//           .verifyLogin(number: '9380544108', otp: otpController.text)
//           .then(
//         (value) async {
//           log("spaekaer type border ${value}");
//           if (value["type"].toString() == "error") {
//             Fluttertoast.showToast(msg: wrongOTP);
//             otpController.clear();
//           } else {
//             log("here we go ${userModel['id'].toString()}");
// log(Platform.isAndroid
//                   ? deviceInfo!.fingerprint
//                   : iosDeviceInfo!.identifierForVendor!,);
//                    log("here we go ${token!}");
//                     log("here we go ${userModel['id'].toString()}");
// //log(iosDeviceInfo!.identifierForVendor!);
//             await networkRepository
//                 .postFCM(
//               fcmToken: token,
//               member: userModel['id'].toString(),
//               phoneMac: Platform.isAndroid
//                   ? deviceInfo!.fingerprint
//                   : iosDeviceInfo!.identifierForVendor!,
//             )
//                 .whenComplete(
//               () {
//                 box!.put("login", true);
//                  Get.toNamed((
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const DashBoardScreen(),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       );
//     } else {
//       Fluttertoast.showToast(msg: enterOTP);
//     }
//   }

  _verifyOtpCode(OtpScreenArguments args) async {}

  _verifyOtpCodeWeb(OtpScreenArguments args) async {
    // final deviceInfoPlugin = DeviceInfoPlugin();
    // AndroidDeviceInfo? deviceInfo;
    // IosDeviceInfo? iosDeviceInfo;
    // if (Platform.isIOS) iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    // if (Platform.isAndroid) deviceInfo = await deviceInfoPlugin.androidInfo;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoadingButton = false;
    });
    if (otpController.text.isNotEmpty) {
      // String? token = await messaging.getToken();

      // String? token = "testtoken";
      await networkRepository
          .verifyLogin(number: args.phoneNumber, otp: otpController.text)
          .then(
        (value) async {
          if (value["type"].toString() == "error") {
            Fluttertoast.showToast(msg: 'Wrong OTP');
            otpController.clear();
          } else {
            var data = value;
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        },
      );
    } else {
      Fluttertoast.showToast(msg: 'Enter OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as OtpScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'GoFlamingoLogo',
          child: Image.asset(
            'assets/images/logo/go_flamingo_logo.png',
            height: 60,
            width: 120,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
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
            OtpTextField(
              numberOfFields: 4,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              fillColor: const Color.fromARGB(255, 233, 233, 233),

              borderWidth: 1,
              filled: true,

              focusedBorderColor: kPrimaryBlue,
              fieldWidth: 55,
              margin: const EdgeInsets.only(right: 10.0, left: 10.0),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                otpController.text = verificationCode;
                _onSubmitOtp(args);
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
                _onClickRetry(args);
              },
              child: const Text(
                'resend OTP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
