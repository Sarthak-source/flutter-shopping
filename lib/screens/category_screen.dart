import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/catagories_controller.dart';
import 'package:sutra_ecommerce/models/category.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/category_card/category_card.dart';
import '../widgets/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category_screen';

  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<CategoriesController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                marginBottom: 12,
                actions: [
                  const Icon(
                    Icons.search,
                    color: kPrimaryBlue,
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                ],
                title: 'All Categories',
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Expanded(
                  child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: controller.categories[index]['name'],
                                categoryId:
                                    controller.categories[index]['id'].toString(),
                              ),
                            );
                    },
                    child: CategoryCard(
                      from: "allcategories",
                      category:  Category(
                                controller.categories[index]['name'],
                                controller.categories[index]['categories_img'],
                                Colors.amber,
                              ),),
                  );
                },
              ))
            ],
          ),
        ),
      );
    });
  }
}
