import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/option_button.dart';
import '../widgets/or_row.dart';
import '../widgets/social_media.dart';
import 'add_address/add_address_screen.dart';
import 'login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signupScreen';

  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
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
                          'Sign Up Continue!',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SocialMediaLogin(
                      method: 'Sign Up',
                    ),
                    const Spacer(),
                    const OrRow(),
                    const Spacer(),
                    const CustomTextField(
                      hint: 'Your Name',
                        TextInputType: TextInputType.text
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CustomTextField(
                            hint: '+62',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ),
                              TextInputType: TextInputType.number
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        const Expanded(
                          flex: 5,
                          child: CustomTextField(
                            hint: 'Phone Number',
                              TextInputType: TextInputType.number
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const CustomTextField(hint: 'Email Address', TextInputType: TextInputType.text),
                    const Spacer(),
                    CustomTextField(
                      hint: 'Password',
                        TextInputType: TextInputType.text,
                      icon: Image.asset('assets/images/hide_icon.png'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddAddressScreen.routeName);
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
  }
}
