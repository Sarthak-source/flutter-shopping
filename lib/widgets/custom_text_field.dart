import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, 
    this.hint,
    this.icon,
    this.onTap,
    this.onChanged,
    this.controller,
    this.TextInputType,
    this.validator,
    this.FocusNode,
        this.inputFormatters, // Add inputFormatters parameter

  });
  final String? hint;
  final Widget? icon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final  TextInputType;
  final String? Function(String?)? validator;
  final FocusNode ;
    final List<TextInputFormatter>? inputFormatters; // Define inputFormatters as a List of TextInputFormatter

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: FocusNode,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: TextInputType,
      inputFormatters: inputFormatters,
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
