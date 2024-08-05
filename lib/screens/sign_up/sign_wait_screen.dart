import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class SignUpWait extends StatefulWidget {
  static const routeName = '/signUpWait';

  const SignUpWait({super.key});

  @override
  State<SignUpWait> createState() => _SignUpWaitState();
}

class _SignUpWaitState extends State<SignUpWait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Lottie.asset(
                      'assets/lotties/please-wait.json',
                      repeat: true,
                      height: getProportionateScreenHeight(200.0),
                      width: getProportionateScreenWidth(200.0),
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    // Text(
                    //   'Registered Waitfully',
                    //   style: Theme.of(context).textTheme.headline6!.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16.0),
                      ),
                      child: Text(
                        'The number is already registered, we are processing your request',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: kTextColorAccent,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
