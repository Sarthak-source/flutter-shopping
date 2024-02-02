import 'package:flutter/material.dart';

///best practices
import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import 'intro_screen/intro_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/landing.png',
                fit: BoxFit.cover,
              ),
            ),
            const IntroWidget()
          ],
        ),
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Welcome to Veggie Fresh',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Text(
              'We have more than 10,000+ food available for all of you.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(IntroScreen.routeName);
              },
              child: const Text('Get Started'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
