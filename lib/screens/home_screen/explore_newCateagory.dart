import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/explore_more_controller.dart';
import 'package:sutra_ecommerce/screens/category_screen/explore_category_screen.dart';
import 'package:sutra_ecommerce/utils/error.dart';

import '../../constants/colors.dart';
import '../../widgets/tab_title.dart';
import '../category_screen/category_screen.dart';
import '../product_grid_screen/produts_grid_screen.dart';

class ExploreNewCategory extends StatelessWidget {
  final ExploreMoreController controller = Get.put(ExploreMoreController());

  ExploreNewCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreMoreController>(builder: (controller) {
      if (controller.isLoading.value) {
        // If the Future is still running, show a loading indicator
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                height: 100,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    9,
                    (index) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            // color: Colors.blue[100 * (index % 9)],
                            //  color: Colors.blue[100 * (1 % 9)],

                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: Column(
                                children: [
                                  const Text(""),
                                  Expanded(child: Container()),
                                ],
                              )),
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ));
      } else if (controller.hasError.value) {
        // If there's an error, display it to the user
        return const ErrorHandleWidget();
      } else {
        return Column(
          children: [
            Container(
              height: 14,
              //  color: Colors.grey.shade300,
              color: kPrimaryBlueTest,
            ),
            Container(
              //color: Colors.grey.shade300,
              color: kPrimaryBlueTest,
              child: TabTitle(
                title: 'Explore New Catrgories',
                seeAll: () {
                  //Get.toNamed(CategoryScreen.routeName);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExploreCategoryScreen(
                                subCatId: null,
                                catName: "Explore Categories",
                              )));
                },
              ),
            ),
            /*  GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      setCatLength(controller.categories.length),
                          (index) {
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
                ),*/

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Get.width >= 600 ? 6 : 3,
                mainAxisSpacing: 2.0, // spacing between rows
                crossAxisSpacing: 2.0, // spacing between columns
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 4), // padding around the grid
              itemCount: setCatLength(
                  controller.exploreMores.length), // total number of items
              itemBuilder: (context, index) {
                var catList = controller.exploreMores;

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  // color: Colors.blue[100 * (index % 9)],
                  //  color: Colors.blue[100 * (1 % 9)],

                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        var checkSubCat =
                            controller.exploreMores[index]["has_sub_category"];
                        if (checkSubCat != null && checkSubCat == true) {
                          // Get.toNamed(CategoryScreen.routeName);
                          if (controller.exploreMores[index]["id"] != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryScreen(
                                          subCatId: controller
                                              .exploreMores[index]["id"]
                                              .toString(),
                                          catName: controller
                                              .exploreMores[index]['name'],
                                        )));
                          }
                        } else {
                          Get.toNamed(
                            PoductsListScreen.routeName,
                            arguments: PoductsListArguments(
                              title: catList.isNotEmpty
                                  ? controller.exploreMores[index]['name']
                                  : "",
                              categoryId: controller.exploreMores[index]['id']
                                  .toString(),
                            ),
                          );
                        }
                      },
                      child: Container(
                          child: Column(
                        children: [
                          Expanded(
                              child: Image.network(catList.isNotEmpty
                                  ? catList[index]['categories_img']
                                  : 'http://170.187.232.148/static/images/dilicia.png')),
                          Text(
                            catList[index]['name'],
                            // titleCase(catList.isNotEmpty ? catList[index]['name'].toLowerCase() : "",),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      )),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }
    });
  }

  int setCatLength(int length) {
    if (length > 9) {
      return 9;
    } else if (length == 6) {
      return 6;
    } else {
      return length;
    }
  }
}
