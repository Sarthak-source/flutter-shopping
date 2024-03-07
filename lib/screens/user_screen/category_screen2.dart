import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/catagories_controller.dart';
import 'package:sutra_ecommerce/models/category.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/category_card/category_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../category_screen.dart';



class CategoryScreen2 extends StatefulWidget {
  static const routeName = '/category_screen';

  final String? subCatId;
  final String? type;
  CategoryScreen2({
    this.subCatId,
    this.type
  });

  @override
  State<CategoryScreen2> createState() => _CategoryScreen2State();
}

class _CategoryScreen2State extends State<CategoryScreen2> {
  final CategoriesController catcontroller = Get.put(CategoriesController());
  @override
  void initState() {
    super.initState();
    if(widget.subCatId !=null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        catcontroller.getSubCategories(widget.subCatId ?? "","2");
      });

    }

  }

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
                    itemCount: widget.subCatId != null?controller.Subcategories2.length:  controller.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      var subCatData= widget.subCatId != null?controller.Subcategories2[index]:null;
                      return InkWell(
                        onTap: () {

                          if(widget.subCatId != null){
                            var checkSubCat = subCatData['has_sub_category'];
                            print('has_sub_category:: ${checkSubCat}');
                            if(checkSubCat != null && checkSubCat == true){
                              if(subCatData["id"] !=null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoryScreen(subCatId: subCatData["id"].toString(),)));
                              }
                            }else {
                              Get.toNamed(
                                PoductsListScreen.routeName,
                                arguments: PoductsListArguments(
                                  title: subCatData['name'],
                                  categoryId:
                                  subCatData['id'].toString(),
                                ),
                              );
                            }
                          }else {
                            Get.toNamed(
                              PoductsListScreen.routeName,
                              arguments: PoductsListArguments(
                                title: controller.categories[index]['name'],
                                categoryId:
                                controller.categories[index]['id'].toString(),
                              ),
                            );
                          }
                        },
                        child: CategoryCard(
                          from: "allcategories",
                          category:  Category(
                            widget.subCatId != null?subCatData['name']:   controller.categories[index]['name'],
                            widget.subCatId != null?subCatData['categories_img']: controller.categories[index]['categories_img'],
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
