import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_container.dart';

class MyProfileScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  static const routeName = '/myProfile';

  MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'My Profile',
              actions: [],
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            const ImageContainer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(60.0),),
                  InputFormCard(
                    title: 'Full name',
                    value:
                        userController.user['party']['party_name'].toString(),
                  ),


                  InputFormCard(
                    title: 'Email',
                    value: userController.user['party']['email'].toString(),
                  ),
                  InputFormCard(
                    title: 'Phone number',
                    value: userController.user['party']['mobile_NO'].toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputFormCard extends StatelessWidget {
  const InputFormCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
            initialValue: value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenWidth(17),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
