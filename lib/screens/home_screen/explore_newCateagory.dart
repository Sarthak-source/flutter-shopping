import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/catagories_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/tab_title.dart';
import '../category_screen.dart';
import '../product_grid_screen/produts_grid_screen.dart';

class ExploreNewCategory extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());

   ExploreNewCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CategoriesController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            // If the Future is still running, show a loading indicator
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: SizedBox(
                  height: 100,
                  child:  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(9, (index) {
                      return  Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 8),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          // color: Colors.blue[100 * (index % 9)],
                          //  color: Colors.blue[100 * (1 % 9)],

                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                  color: Colors.grey
                              ),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Column(
                                  children: [
                                    Text(""),
                                    Expanded(child: Container()),
                                  ],
                                )
                            ),
                          ),
                        )
                      );
                    },
                    ),
                ),
              ),)
            );
          } else if (controller.hasError.value) {
            // If there's an error, display it to the user
            return Center(child: Text('Error: ${controller.errorMsg.value}'));
          } else {
            return Column(
              children: [
                Container(
                  height: 14,
                  color: Colors.grey.shade300,
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: TabTitle(
                    title: 'Explore More Catrgories',
                    seeAll: () {
                      Get.toNamed(CategoryScreen.routeName);
                    },
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(9, (index) {
                    var catList = controller.categories;

                    return Container(
                      margin: EdgeInsets.all(8.0),
                      // color: Colors.blue[100 * (index % 9)],
                      //  color: Colors.blue[100 * (1 % 9)],

                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: catList.isNotEmpty ? controller
                                    .categories[index]['name'] : "",
                                categoryId:
                                controller.categories[index]['id'].toString(),
                              ),
                            );
                          },
                          child: Container(
                              child: Column(
                                children: [
                                  Text(titleCase(
                                    catList.isNotEmpty ? catList[index]['name']
                                        .toLowerCase() : "",), style: Theme
                                      .of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(11),
                                  ),),
                                  Expanded(child: Image.network(
                                      catList.isNotEmpty
                                          ? catList[index]['categories_img']
                                          : 'http://170.187.232.148/static/images/dilicia.png')),
                                ],
                              )
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          }
        }
    );
  }
}