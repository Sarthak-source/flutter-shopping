import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/catagories_controller.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';
import 'package:sutra_ecommerce/screens/user_screen/category_screen2.dart';

import '../constants/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_widgets/loader.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category_screen';

  final String? subCatId;

  const CategoryScreen({
    super.key,
    this.subCatId,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoriesController catcontroller = Get.put(CategoriesController());
  @override
  void initState() {
    super.initState();
    if (widget.subCatId != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        catcontroller.getSubCategories(widget.subCatId ?? "", "1");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<CategoriesController>(builder: (controller) {
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: widget.subCatId != null
                          ? controller.Subcategories.length
                          : controller.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        var subCatData = widget.subCatId != null
                            ? controller.Subcategories[index]
                            : null;
                        return InkWell(
                          onTap: () {
                            if (widget.subCatId != null) {
                              var checkSubCat = subCatData['has_sub_category'];
                              print('has_sub_category:: ${checkSubCat}');
                              if (checkSubCat != null && checkSubCat == true) {
                                if (subCatData["id"] != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryScreen2(
                                                subCatId:
                                                    subCatData["id"].toString(),
                                                type: "2",
                                              )));
                                }
                              } else {
                                Get.toNamed(
                                  PoductsListScreen.routeName,
                                  arguments: PoductsListArguments(
                                    title: subCatData['name'],
                                    categoryId: subCatData['id'].toString(),
                                  ),
                                );
                              }
                            } else {
                              Get.toNamed(
                                PoductsListScreen.routeName,
                                arguments: PoductsListArguments(
                                  title: controller.categories[index]['name'],
                                  categoryId: controller.categories[index]['id']
                                      .toString(),
                                ),
                              );
                            }
                          },
                          child: Container(
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
                                  Get.toNamed(
                                    PoductsListScreen.routeName,
                                    arguments: PoductsListArguments(
                                      title: controller.categories.isNotEmpty
                                          ? controller.categories[index]['name']
                                          : "",
                                      categoryId: controller.categories[index]
                                              ['id']
                                          .toString(),
                                    ),
                                  );
                                },
                                child: Container(
                                    child: Column(
                                  children: [
                                    Expanded(
                                        child: Image.network(
                                            widget.subCatId != null? controller.Subcategories[index]['categories_img'] : controller.categories[index]['categories_img']
                                            //: 'http://170.187.232.148/static/images/dilicia.png'
                                        )
                                    ),
                                    Text(
                                      widget.subCatId != null? controller.Subcategories[index]['name']:controller.categories[index]['name'],
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
