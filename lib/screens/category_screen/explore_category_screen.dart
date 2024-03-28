import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/explore_more_controller.dart';
import 'package:sutra_ecommerce/screens/category_screen/category_screen2.dart';

import '../../utils/screen_utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_widgets/loader.dart';
import '../product_grid_screen/produts_grid_screen.dart';

class ExploreCategoryScreen extends StatefulWidget {
  static const routeName = '/explore_category_screen';

  final String? subCatId;
  final String? catName;

  const ExploreCategoryScreen({
    super.key,
    this.subCatId,
    this.catName,
  });

  @override
  State<ExploreCategoryScreen> createState() => _ExploreCategoryScreenState();
}

class _ExploreCategoryScreenState extends State<ExploreCategoryScreen> {
  final ExploreMoreController catcontroller = Get.put(ExploreMoreController());
  @override
  void initState() {
    super.initState();
    if (widget.subCatId != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        catcontroller.fetchExploreMores();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<ExploreMoreController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
        //  backgroundColor: kPrimaryBlueTest,
        body: SafeArea(
          child: catcontroller.isLoading.value
              ? const Loader()
              : Column(
                  children: [
                    CustomAppBar(
                      marginBottom: 12,
                      actions: [
                        // const Icon(
                        //   Icons.search,
                        //   color: kPrimaryBlue,
                        // ),
                        SizedBox(
                          width: getProportionateScreenWidth(16),
                        ),
                      ],
                      title: widget.catName ?? "",
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    //Text(controller.Subcategories.toString()),
                    Expanded(
                        child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: widget.subCatId != null
                          ? controller.exploreMores.length
                          : controller.exploreMores.length,
                      itemBuilder: (BuildContext context, int index) {
                        var subCatData = widget.subCatId != null
                            ? controller.exploreMores[index]
                            : null;
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
                                if (widget.subCatId != null) {
                                  var checkSubCat =
                                      subCatData['has_sub_ExploreCategory'];
                                  print(
                                      'has_sub_ExploreCategory:: ${checkSubCat}');
                                  if (checkSubCat != null &&
                                      checkSubCat == true) {
                                    if (subCatData["id"] != null) {
                                      log(subCatData[index].toString());

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen2(
                                                    catName: subCatData['name'],
                                                    subCatId: subCatData["id"]
                                                        .toString(),
                                                    type: "2",
                                                  )));
                                    }
                                  } else {
                                    //log(subCatData[index]['id'].toString());
                                    Get.toNamed(
                                      PoductsListScreen.routeName,
                                      arguments: PoductsListArguments(
                                        title: subCatData['name'],
                                        categoryId: subCatData['id'].toString(),
                                      ),
                                    );
                                  }
                                } else {
                                  /*      log(controller.categories[index]['id'].toString());
                                  Get.toNamed(
                                    PoductsListScreen.routeName,
                                    arguments: PoductsListArguments(
                                      title: controller.categories[index]
                                          ['name'],
                                      ExploreCategoryId: controller.categories[index]
                                              ['id']
                                          .toString(),
                                    ),
                                  );*/

                                  var checkSubCat = controller.exploreMores[index]
                                      ["has_sub_ExploreCategory"];
                                  if (checkSubCat != null &&
                                      checkSubCat == true) {
                                    // Get.toNamed(ExploreCategoryScreen.routeName);
                                    if (controller.exploreMores[index]["id"] !=
                                        null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExploreCategoryScreen(
                                                    subCatId: controller
                                                        .exploreMores[index]["id"]
                                                        .toString(),
                                                    catName: controller
                                                                .exploreMores[
                                                            index]["name"] ??
                                                        "",
                                                  )));
                                    }
                                  } else {
                                    Get.toNamed(PoductsListScreen.routeName,
                                        arguments: PoductsListArguments(
                                          title: controller.exploreMores[index]
                                              ['name'],
                                          categoryId: controller
                                              .exploreMores[index]['id']
                                              .toString(),
                                        ));
                                  }
                                }
                                // Get.toNamed(
                                //   PoductsListScreen.routeName,
                                //   arguments: PoductsListArguments(
                                //     title: controller.categories.isNotEmpty
                                //         ? controller.categories[index]['name']
                                //         : "",
                                //     ExploreCategoryId: controller.categories[index]
                                //             ['id']
                                //         .toString(),
                                //   ),
                                // );
                              },
                              child: Container(
                                  child: Column(
                                children: [
                                  Expanded(
                                      child: Image.network(
                                          widget.subCatId != null
                                              ? controller.exploreMores[index]
                                                  ['categories_img']
                                              : controller.exploreMores[index]
                                                  ['categories_img']
                                          //: 'http://170.187.232.148/static/images/dilicia.png'
                                          )),
                                  Text(
                                    widget.subCatId != null
                                        ? controller.exploreMores[index]
                                            ['name']
                                        : controller.exploreMores[index]['name'],
                                    // titleCase(catList.isNotEmpty ? catList[index]['name'].toLowerCase() : "",),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              getProportionateScreenWidth(11),
                                        ),
                                  ),
                                ],
                              )),
                            ),
                          ),
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
