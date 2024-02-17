import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/catagories_controller.dart';
import 'package:sutra_ecommerce/models/category.dart';
import 'package:sutra_ecommerce/screens/category_screen.dart';
import 'package:sutra_ecommerce/screens/product_screen/produts_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
import 'package:sutra_ecommerce/widgets/category_card/category_card.dart';

class CategoryTab extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());

  CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(CategoryScreen.routeName);
                },
                child: const Text(
                  'See All',
                ),
              )
            ],
          ),
          GetBuilder<CategoriesController>(
            builder: (controller) {
              if (controller.isLoading.value) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Use a placeholder count
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: CategoryCardPlaceholder(),
                        );
                      },
                    ),
                  ),
                );
              } else if (controller.hasError.value) {
                return Text('Error: ${controller.errorMsg.value}');
              } else {
                return SizedBox(
                  height: 140,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: controller.categories[index]['name'],
                                categoryId: controller.categories[index]['id'],
                              ),
                            );
                          },
                          child: CategoryCard(
                            Category(
                              controller.categories[index]['name'],
                              controller.categories[index]['categories_img'],
                              Colors.amber,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}