import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sutra_ecommerce/screens/login/verify_otp.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

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
  TextEditingController otpController = TextEditingController(text: "");
  late Box otpBox;

  String selectedStateId = "";
  bool showOtp = false;

  int otpCount = 0;
  DateTime? lastOtpTimestamp;

  Future<Map<String, dynamic>> initHive() async {
    otpBox = await Hive.openBox('otpBox');
    var otpData = otpBox.get(phoneController.text, defaultValue: {
      'count': 0,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
    return otpData;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<LoginController>(
      builder: (ctrlr) {
        return FutureBuilder(
          future: initHive(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            return Scaffold(
              body: !showOtp
                  ? SafeArea(
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
                                    TextInputType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: kGreyShade3),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getProportionateScreenWidth(15),
                                              )),
                                          child:
                                              const Center(child: Text("+91")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(10),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: CustomTextField(
                                          controller: phoneController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          hint: 'Phone Number',
                                          validator: (value) {
                                            if (value!.length != 10 ||
                                                value.isEmpty) {
                                              return 'Please enter a valid number';
                                            }
                                            return null;
                                          },
                                          TextInputType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  StateDropdown(
                                    hinttxt: "Select State",
                                    devicewidth: Get.width / 2 + 10,
                                    selectedValue: selectedState,
                                    options: ctrlr.stateList,
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          selectedState = value;
                                          selectedStateId =
                                              selectedState?["id"].toString() ??
                                                  "";
                                        });
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (nameController.text.isNotEmpty &&
                                          phoneController.text.length == 10 &&
                                          selectedStateId.isNotEmpty) {
                                        var otpData =
                                            otpBox.get(phoneController.text);

                                        int otpCount = otpData?['count'] ?? 0;
                                        DateTime? lastOtpTimestamp =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                otpData?['timestamp'] ?? 0);

                                        if (DateTime.now()
                                                .difference(lastOtpTimestamp)
                                                .inHours >=
                                            1) {
                                          otpCount = 0;
                                        }

                                        if (otpCount <= 2) {
                                          var data =
                                              await networkRepository.userLogin(
                                            number: phoneController.text,
                                          );

                                          if (data['type'] == 'success') {
                                            otpCount += 1;

                                            var newOtpData = {
                                              'count': otpCount,
                                              'timestamp': DateTime.now()
                                                  .millisecondsSinceEpoch
                                            };
                                            otpBox.put(phoneController.text,
                                                newOtpData);

                                            setState(() {
                                              showOtp = true;
                                              this.otpCount = otpCount;
                                              this.lastOtpTimestamp =
                                                  DateTime.now();
                                            });
                                          }
                                        } else {
                                          DateTime nextTryTime =
                                              lastOtpTimestamp.add(
                                                  const Duration(hours: 1));

                                          String formattedTime = '';

                                          if (nextTryTime.hour >= 12) {
                                            formattedTime =
                                                '${(nextTryTime.hour - 12).toString().padLeft(2, '0')}:${nextTryTime.minute.toString().padLeft(2, '0')} PM';
                                          } else {
                                            formattedTime =
                                                '${nextTryTime.hour.toString().padLeft(2, '0')}:${nextTryTime.minute.toString().padLeft(2, '0')} AM';
                                          }

                                          Fluttertoast.showToast(
                                            msg:
                                                "Please try again in $formattedTime",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Please fill in all the fields",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    },
                                    child: const Text('Sign Up'),
                                  ),
                                  const Spacer(),
                                  OptionButton(
                                    desc: 'Have an account? ',
                                    method: 'Login',
                                    onPressHandler: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LoginScreen.routeName);
                                    },
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(80),
                          ),
                          Text(
                            'Enter OTP',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
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
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
                                        fontSize: 16.0,
                                      ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'We have sent verification code\nto ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            getProportionateScreenWidth(16),
                                      ),
                                ),
                                TextSpan(
                                  text: '+91-${phoneController.text}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryBlue,
                                        fontSize:
                                            getProportionateScreenWidth(16),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            fillColor: const Color.fromARGB(255, 233, 233, 233),
                            borderWidth: 1,
                            filled: true,
                            textStyle: const TextStyle(fontSize: 20),
                            focusedBorderColor: kPrimaryBlue,
                            fieldWidth: 60,
                            margin:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              otpController.text = verificationCode;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (otpController.text.isNotEmpty) {
                                  loginController.verifyOtpCode(
                                      OtpScreenArguments(
                                        phoneNumber: phoneController.text,
                                      ),
                                      otpController,
                                      context,
                                      nameController.text,
                                      phoneController.text,
                                      selectedStateId,
                                      'signUp');
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please enter the OTP",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: const Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
