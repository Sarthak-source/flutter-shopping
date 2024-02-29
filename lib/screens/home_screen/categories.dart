import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/catagories_controller.dart';
import 'package:sutra_ecommerce/models/category.dart';
import 'package:sutra_ecommerce/screens/category_screen.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';
import 'package:sutra_ecommerce/widgets/category_card/category_card.dart';

import '../../widgets/tab_title.dart';

class CategoryTab extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());

  CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(0),
      ),
      child: Container(
      //  color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabTitle(
                title: "",
                seeAll: () {
                  Get.toNamed(CategoryScreen.routeName);
                }),

          /*  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(CategoryScreen.routeName);
                  },
                  child: Text(
                      'See All',
                    style: const TextStyle(fontSize: 12,color: kPrimaryBlue),
                  ),
                ),
        SizedBox(width: 16,)
              ],
            ),*/
            GetBuilder<CategoriesController>(
              builder: (controller) {
                var catData=  controller.categories;
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: SizedBox(
                      height: 140,
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
                }
                else if (controller.hasError.value) {
                  return Text('Error: ${controller.errorMsg.value}');
                } else {
                  return Container(
                    height: 88,
                   // color: Colors.red,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: catData.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: catData.isNotEmpty?catData[index]['name']:"",
                                categoryId: controller.categories[index]['id'].toString(),
                              ),
                            );
                          },
                          child: CategoryCard(
                            from: "homecategory",
                            category: Category(
                              catData.isNotEmpty? catData[index]['name']:"",
                              catData.isNotEmpty?catData[index]['categories_img']:"",
                              Colors.amber,
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
      ),
    );
  }
}
