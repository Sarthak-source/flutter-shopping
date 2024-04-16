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
                    title: 'Full Name',
                    value: userController.user['party']['party_name'].toString(),
                  ),
                  InputFormCard(
                    title: 'Email',
                    value: userController.user['party']['email'].toString(),
                  ),
                  InputFormCard(
                    title: 'Mobile',
                    value: userController.user['party']['mobile_NO'].toString(),
                  ),
                  InputFormCard(
                    title: 'GST',
                    value: userController.user['party']['address']['gstin'] != null ?userController.user['party']['address']['gstin']['gstin'].toString():"",
                  ),
                  InputFormCard(
                    title: 'Order Milk',
                    value: userController.user['party']['orders_milk'] != null ?userController.user['party']['orders_milk'].toString():"",
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
          flex: 1,
          child: Text(
            title,
            style: TextStyle(
              color: kTextColorAccent,
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            initialValue: value,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenWidth(14),
            ),
            maxLines: 1,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
