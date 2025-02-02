import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/back_button_ls.dart';
import '../widgets/custom_text_field.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map_screen';

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButtonLS(),
                Text(
                  'Choose Your Address',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(32),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/map_pattern.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/curLoc.png',
                    ),
                  ),
                  const BottomCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: SizedBox(
                width: getProportionateScreenWidth(56),
                height: getProportionateScreenWidth(56),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: kPrimaryBlue,
                  child: Icon(
                    Icons.gps_fixed,
                    size: getProportionateScreenWidth(32),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getProportionateScreenWidth(
                      8,
                    ),
                  ),
                  topRight: Radius.circular(
                    getProportionateScreenWidth(
                      8,
                    ),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Planet Namex 989',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.search,
                          size: getProportionateScreenWidth(32),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      'Norristown, Pennsylvania, 19403',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: kTextColorAccent,
                          ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      'Detail Address',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: kTextColorAccent,
                          ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    const CustomTextField(
                      hint: 'Write down the building, apartment or office...',
                      TextInputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('Add Address'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
