import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/tab_screen.dart';
import '../utils/screen_utils.dart';

class OrderSuccessScreenold extends StatelessWidget {
  static const routeName = '/orderSuccessold';

  const OrderSuccessScreenold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset('assets/images/wallet_illu.png'),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Order Successfully',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16.0),
                    ),
                    child: Text(
                      'Thank you for the order Your order will be prepared and shipped by courier within 1-2 days',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: kTextColorAccent,
                          ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(TabScreen.routeName);
                },
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
