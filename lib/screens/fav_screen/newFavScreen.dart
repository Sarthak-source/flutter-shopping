import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';

class newFavScreen extends StatefulWidget {
  const newFavScreen({super.key});

  @override
  State<newFavScreen> createState() => _newFavScreenState();
}

class _newFavScreenState extends State<newFavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Visibility(
        visible: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: Column(children: [
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Text(
                  'My Favorite',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(
                      20,
                    ),
                  ),
                ),
                const Spacer(),
                // const Icon(
                //   Icons.search,
                //   color: kPrimaryBlue,
                // ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Row(
              children: [
                // const Icon(
                //   Icons.search,
                //   color: kPrimaryBlue,
                // ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Lottie.asset('assets/lotties/cart.json',
                repeat: false,
                height: getProportionateScreenHeight(250.0),
                width: getProportionateScreenWidth(250.0)),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            Text(
              'Oops Your Wishlist Is Empty',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Text(
              'It seems noting in here. Explore more and shortlist some items',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: kTextColorAccent,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       cmncontroller.commonCurTab.value = 0;
            //       cmncontroller.update();
            //     },
            //     child: const Text(
            //       'Start Shopping',
            //     ),
            //   ),
            SizedBox(
              height: getProportionateScreenHeight(200),
            ),
          ]),
        ),
      ),
    );
  }
}
