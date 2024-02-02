import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, 
    this.hint,
    this.icon,
    this.onChanged,
  });
  final String? hint;
  final Widget? icon;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(15),
          ),
          borderSide: const BorderSide(
            color: kGreyShade3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(15),
          ),
          borderSide: const BorderSide(
            color: kGreyShade3,
          ),
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: kGreyShade3,
            ),
        suffixIcon: icon,
      ),
    );
  }
}
