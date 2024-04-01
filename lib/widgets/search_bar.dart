import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/products_controller.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class SearchBar extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

  const SearchBar({this.hint, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
   final ProductController productController = Get.put(ProductController(categoryId: ''));
    // final ProductController productController =
    //     Get.find(); // Get ProductController

        
    return TextField(
      controller: controller,
      onChanged: (value) {
        // Update search term directly in ProductController
        productController.searchTerm = value;
        // Fetch products whenever search term changes
        productController.fetchProducts();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kFillColorThird,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(4)),
          
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
        ),
        hintStyle: TextStyle(
          color: kGreyShade2,
          fontSize: getProportionateScreenWidth(14),
        ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
