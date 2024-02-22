import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/get_deals_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/home_screen/components/categories/categories.dart';
import 'package:sutra_ecommerce/screens/home_screen/components/popular_deal/popular_deals.dart';
import 'package:sutra_ecommerce/screens/map_screen.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/deal_card.dart';
import '../../widgets/tab_title.dart';
import '../search_screen/search_screen.dart';
import '../special_deal_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final UserController userController = Get.put(UserController());

  //  @override
  // void initState() {
  //   super.initState();
  //   userController.getUserData();
  // }
  
  @override
  
  Widget build(BuildContext context) {
    ScreenUtils().init(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HomeAppBar(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Hero(
              tag: 'search',
              child: SearchBar(
                elevation: MaterialStateProperty.resolveWith<double?>(
                  (Set<MaterialState> states) {
                    // Define the elevation based on different states
                    if (states.contains(MaterialState.pressed)) {
                      return 5.0; // Elevation when pressed
                    }
                    return 2.0; // Default elevation
                  },
                ),
                hintText: 'Search...',
                hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                  (Set<MaterialState> states) {
                    // Define the TextStyle based on different states
                    if (states.contains(MaterialState.pressed)) {
                      return const TextStyle(
                        color:
                            Colors.blue, // Change the text color when pressed
                        fontStyle: FontStyle
                            .italic, // Change the font style when pressed
                        fontSize: 16, // Change the font size when pressed
                        // Add any other TextStyle properties you want to customize
                      );
                    }
                    return const TextStyle(
                      color: Colors.grey, // Default text color
                      fontStyle: FontStyle.normal, // Default font style
                      fontSize: 16, // Default font size
                      // Add any other TextStyle properties you want to customize
                    );
                  },
                ),
                onTap: () {
                  Get.toNamed(SearchScreen.routeName);
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: CategoryTab()),
        SliverToBoxAdapter(
          child: DealsTab(),
        ),
        SliverToBoxAdapter(
          child: TabTitle(
            title: 'Popular Deals',
            seeAll: () {
              Get.toNamed(PoductsListScreen.routeName);
            },
          ),
        ),
         PopularDealTab(),
      ],
    );
  }
}

class DealsTab extends StatelessWidget {
  final DealsController controller = Get.put(DealsController());

  DealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(
            title: 'Special Deals for You',
            seeAll: () {
              Get.toNamed(SpecialDealScreen.routeName);
            }),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        GetBuilder<DealsController>(builder: (context) {
          return SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  controller.deals.length, // Set the total number of items
              itemBuilder: (BuildContext context, int index) {
                // Return your item widget based on the index
                //log(controller.deals.toString());
                return InkWell(
                  onTap: () {
                    log('message, ${controller.deals[index]}');
                    Get.toNamed(
                      PoductsListScreen.routeName,
                      arguments: PoductsListArguments(
                        title: controller.deals[index]['heading'],
                        categoryId: controller.deals[index]['category'].toString(),
                      ),
                    );
                  },
                  child: DealCard(
                    image: controller.deals[index]['deal_img'],
                    heading: controller.deals[index]['heading'],
                  ),
                ); // Replace with your actual item widget
              },
            ),
          );

          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       DealCard(),
          //       DealCard(),
          //     ],
          //   ),
          // );
        }),
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
         () {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(
                    16,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(MapScreen.routeName);
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.location_fill,
                            color: kPrimaryBlue,
                          )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Text(userController.user.toString()),
                            Text(
  userController.user['party']?['address']?['address_line1'] ?? 'Loading...',
  style: Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(
        fontWeight: FontWeight.w700,
      ),
),
Text(
  userController.user['party']?['address']?['address_line2'] ?? '',
  style: TextStyle(
    color: kTextColorAccent,
    fontSize: getProportionateScreenWidth(12),
  ),
),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
    
  
  


// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Row(
//             children: [
//               Expanded(
//                 child: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       return ListTile(
//                         title: Text('Item $index'),
//                       );
//                     },
//                     childCount: 10,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10.0,
//                     crossAxisSpacing: 10.0,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       return Container(
//                         color: Colors.blue[100 * (index % 9)],
//                         child: Center(
//                           child: Text('Grid Item $index'),
//                         ),
//                       );
//                     },
//                     childCount: 10,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
