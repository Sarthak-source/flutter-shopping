import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sutra_ecommerce/assets/logo.dart';
import 'package:sutra_ecommerce/screens/tab_screen.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/option_button.dart';
import '../signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController(text: '');
  bool repeat = false;
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
    //       Navigator.of(context).pushNamed(TabScreen.routeName);
    //     }
    //   });
    // }

    userExists(String phoneNumberTyped) async {
      log(phoneNumberTyped);
      await networkRepository.checkUser(number: phoneNumberTyped).then(
            (value) => {
              log(value)
              // if (value[''] == '')
              //   {
              //     Navigator.of(context).pushNamed(TabScreen.routeName),
              //   }
            },
          );
    }

    return Scaffold(
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
                  // Center(
                  //   child: FutureBuilder(
                  //     future: readJsonFile('assets/lotties/logo.json'),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         if (snapshot.hasError) {
                  //           log('Error: ${snapshot.error}');
                  //           return Text('Error: ${snapshot.error}');
                  //         }
                  //         String jsonContent = snapshot.data!;
                  //         log(jsonContent);
                  //         return Text(jsonContent);
                  //       } else {
                  //         return CircularProgressIndicator();
                  //       }
                  //     },
                  //   ),
                  // ),
                  Transform.translate(
                      offset: const Offset(-60, -50),
                      child:
                          Transform.scale(scale: 0.5, child: BouncingLogo())),

                  SizedBox(
                    height: getProportionateScreenHeight(60),
                  ),

                  Row(
                    children: [
                      Text(
                        'Log In Continue!',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomTextField(
                    hint: 'Phone number',
                    controller: phoneNumberController,
                    //onChanged: handlePhoneNumberChange,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      String phoneNumber = phoneNumberController.text;
                      if (phoneNumber.length < 10) {
                        // Handle the case where the phone number is too short
                        Fluttertoast.showToast(
                          msg: 'Enter a proper number',
                          backgroundColor: Colors.red,
                        );
                      } else {
                        log(phoneNumber);
                        await userExists(phoneNumber);
                      }
                      Navigator.of(context).pushNamed(TabScreen.routeName);
                    },
                    child: const Text('Continue'),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  OptionButton(
                    desc: 'Don\'t have an account? ',
                    method: 'Sign Up',
                    onPressHandler: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class BouncingLogo extends StatefulWidget {
  @override
  _BouncingLogoState createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo>
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
