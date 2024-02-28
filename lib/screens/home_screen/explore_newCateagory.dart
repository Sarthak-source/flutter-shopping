import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/catagories_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
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
      return GridView.count(
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
                onTap: (){
                  Get.toNamed(
                    PoductsListScreen.routeName,
                    arguments: PoductsListArguments(
                      title: catList.isNotEmpty ?controller.categories[index]['name']: "",
                      categoryId:
                      controller.categories[index]['id'].toString(),
                    ),
                  );
                },
                child: Container(
                    child: Column(
                      children: [
                        Text(titleCase(catList.isNotEmpty ?catList[index]['name'].toLowerCase():"",),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(11),
                        ),),
                        Expanded(child: Image.network( catList.isNotEmpty ?catList[index]['categories_img'] : 'http://170.187.232.148/static/images/dilicia.png')),
                      ],
                    )
                ),
              ),
            ),
          );
        }),
      );}
    );
  }
}