import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/add_address/add_address_screen.dart';
import 'package:sutra_ecommerce/widgets/add_button.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/image_container.dart';
import '../my_profile_screen.dart';
import '../myorders_screen.dart';

class UserScreen extends StatelessWidget {
  final UserController? userController = Get.put(UserController());

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(userController?.user.toString() ?? "sss");
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ImageContainer(),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
           // const AddButton(),
            // ...

// ...


            //  CustomPaint(
            //     size: const Size(100, 100),
            //     painter: EveningPainter(),
            //   ),
            Text(
                userController?.user!=null? userController!.user['party']['party_name'].toString(): "",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              userController?.user!=null? userController!.user['party']['email'].toString():"",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40.0),
            ),
            ProfileCard(
              image: 'assets/images/profile_user.png',
              color: kAccentGreen,
              title: 'My profile',
              tapHandler: () {
                Get.toNamed(MyProfileScreen.routeName);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            // ProfileCard(
            //   image: 'assets/images/profile_user.png',
            //   color: kAccentGreen,
            //   title: 'Select time',
            //   tapHandler: () {
            //     Get.toNamed(SelectTime.routeName);
            //   },
            // ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/map_user.png',
              color: kAccentTosca,
              title: 'My Address',
              tapHandler: () {
                Get.toNamed(AddAddressScreen.routeName);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              image: 'assets/images/noti_user.png',
              color: kAccentYellow,
              title: 'Notification',
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              image: 'assets/images/check_user.png',
              color: kAccentPurple,
              title: 'Help Center',
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              image: 'assets/images/arrow_user.png',
              color: kAccentRed,
              title: 'My Orders',
              tapHandler: () {
                // Navigator.of(context).pushNamed(MyOrders.routeName);
                Get.toNamed(MyOrders.routeName);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              image: 'assets/images/arrow_user.png',
              color: kAccentRed,
              title: 'Log out',
            ),
            const Spacer(),
            Text(
              'ver 1.01',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.image,
    required this.title,
    this.tapHandler,
    required this.color,
  }) : super(key: key);

  final String image;
  final String title;
  final Function()? tapHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8.0),
              ),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
              child: Image.asset(image),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8.0),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
