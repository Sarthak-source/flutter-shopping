import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_container.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/myProfile';

  const MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(  title: 'My Profile', actions: [],),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            const ImageContainer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: Column(
                children: [
                  Divider(
                    height: getProportionateScreenHeight(64.0),
                  ),
                  const InputFormCard(
                    title: 'Full name',
                    value: 'Shoo Phar Nhoe', 
                  ),
                  const InputFormCard(
                    title: 'Birthdate',
                    value: '29 February 1200',
                  ),
                  const InputFormCard(
                    title: 'Gender',
                    value: 'Male',
                  ),
                  const InputFormCard(
                    title: 'Email',
                    value: 'shoophar@email.com',
                  ),
                  const InputFormCard(
                    title: 'Phone number',
                    value: '(+78) 8989 8787',
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
              fontWeight: FontWeight.w700,
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
