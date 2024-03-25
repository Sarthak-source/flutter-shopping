import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

class SignUpSuccess extends StatefulWidget {
  static const routeName = '/signUpSuccess';

  const SignUpSuccess({super.key});

  @override
  State<SignUpSuccess> createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Lottie.asset(
                    'assets/lotties/OrderSuccessAnimation.json',
                    repeat: false,
                    height: getProportionateScreenHeight(200.0),
                    width: getProportionateScreenWidth(200.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Registered Successfully',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16.0),
                    ),
                    child: Text(
                      'Registered Successfully, Our Sales person will get in touch with you.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
    );
  }
}
