import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/introScreen';

  const IntroScreen({super.key});

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  int pageCount = 0;

  final PageController _controller = PageController();

  void setPageCount(int aPageCount) {
    setState(() {
      pageCount = aPageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: Column(
        children: [
          IllustrationPageView(_controller, setPageCount),
          TextView(pageCount),
        ],
      ),
    );
  }
}

class TextView extends StatelessWidget {
  final int pageCount;

  const TextView(this.pageCount, {super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {
        'title': 'Dilicia products',
        'desc':
            'Milk is directly procured from farmers with guaranteed quality',
      },
      {
        'title': 'Easy to place orders',
        'desc':
            'Place orders while you are on go.',
      },
      {
        'title': 'Fast Delivery',
        'desc':
            'Dilicia delivers ordered products to distrubutors door',
      },
    ];
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              data[pageCount]['title']!,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            Text(
              data[pageCount]['desc']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColorAccent,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageIndicator(pageCount, 0),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                PageIndicator(pageCount, 1),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                PageIndicator(pageCount, 2),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                //Get.toNamed(LoginScreen.routeName);
                Get.offNamed(LoginScreen.routeName);
              },
              child: const Text(
                'Get Started',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator(this.pageCount, this.index, {super.key});

  final int pageCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: pageCount == index
          ? getProportionateScreenWidth(32)
          : getProportionateScreenWidth(8),
      height: getProportionateScreenWidth(8),
      decoration: BoxDecoration(
        color: pageCount == index ? kPrimaryBlue : kFillColorPrimary,
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(4),
        ),
      ),
    );
  }
}

class IllustrationPageView extends StatelessWidget {
  final PageController controller;
  final Function(int) callback;

  const IllustrationPageView(
    this.controller,
    this.callback, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        color: kPrimaryBlueBG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Container(
             // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: kTextColorForth,
                        fontSize: 12
                          ),
                    ),
                  ),
               /*   SizedBox(
                    width: getProportionateScreenWidth(20),
                  )*/
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (pageNum) {
                  callback(pageNum);
                },
                children: [
                  Image.asset(
                    'assets/images/dilicia_good_image.jpeg',
                  ),
                  Image.asset(
                    'assets/images/illu2.png',
                  ),
                  Image.asset(
                    'assets/images/illu3.png',
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
