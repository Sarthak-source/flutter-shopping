import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/assets/logo.dart';

import '../constants/colors.dart';
import 'intro_screen/intro_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  static const routeName = '/landing_screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(200, 0),
    ).animate(_controller);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 0.30,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlueTest,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context,child) {
                return Transform.translate(
                  offset: const Offset(-25, -10),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: CustomPaint(
                      size: const Size(90, 90),
                      painter: Logo(),
                    ),
                  ),
                );
              }
            ),
            Expanded(
              flex: 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _offsetAnimation.value,
                    child: Transform.scale(
                      scale: 2.2,
                      child: Image.asset(
                        'assets/images/all_product.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
            const IntroWidget(),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Welcome to Dilicia',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                  ),
                ),
               // const Spacer(),
              ],
            ),
          //  const Spacer(),
            const SizedBox(
              height: 16,
            ),
            Text(
            //  'The delightful experience with purely rich taste.',
              'Purely rich taste.',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                   // color: kTextColorAccent,
                    color: const Color.fromARGB(255, 118, 118, 118),
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
               // Get.toNamed(IntroScreen.routeName);
                Get.offNamed(IntroScreen.routeName);
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
