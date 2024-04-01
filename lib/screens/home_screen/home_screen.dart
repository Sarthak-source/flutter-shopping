import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/get_deals_controller.dart';
import 'package:sutra_ecommerce/controllers/user_controller.dart';
import 'package:sutra_ecommerce/screens/home_screen/categories.dart';
import 'package:sutra_ecommerce/screens/home_screen/explore_more_products.dart';
import 'package:sutra_ecommerce/screens/home_screen/popular_deals.dart';
import 'package:sutra_ecommerce/screens/product_grid_screen/produts_grid_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../controllers/catagories_controller.dart';
import '../../controllers/popular_controller.dart';
import '../../utils/common_functions.dart';
import '../../utils/screen_utils.dart';
import '../../utils/shimmer_placeholders/myorder_shimmer.dart';
import '../../widgets/deal_card.dart';
import '../../widgets/tab_title.dart';
import '../search_screen/search_screen.dart';
import '../special_deal_screen.dart';
import 'explore_newCateagory.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AddToCartController addToCardController = Get.find();

  //final DealsController dealsController = Get.find();
//  final CategoriesController categoriesController = Get.find();
  //final PopularDealController popularController = Get.find();
  final dealsController = Get.put(DealsController());
  final categoriesController = Get.put(CategoriesController());
  final popularController = Get.put(PopularDealController(categoryId: ""));
  final controller = Get.put(DealsController());
  final usercontroller = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    print('home screen:::');

    /*dealsController.fetchDealss();
    dealsController.update();
    categoriesController.getCategories();
    categoriesController.update();
    popularController.fetchPopularDeals();
    popularController.update();*/
    // userController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);

    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');

        return false;
      },
      child: Obx(
        () =>  usercontroller.isUpdate.value &&  Platform.isAndroid?  AlertDialog(
          title: Text('New Version Available'),
          content: Text(
              'A new version of the app is available. Please update to continue using the app. localVersion : ${usercontroller.localVersion.value.toString()} and App buildNumber : ${usercontroller.buildversion.value.toString()}'),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Ignore'),
            //   onPressed: () async{
            // Get.back();
            //   },
            // ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                var url =
                    "https://play.google.com/store/apps/details?id=com.dilicia.sutra_ecommerce";
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                  exit(0);
                } else {}
              },
            ),
          ],
        ) : CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: kPrimaryBlueTest2,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(14),
                          vertical: 0),
                      child: Hero(
                        tag: 'search',
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.4),
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 0.4, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Border radius
                          ),
                          child: SearchBar(
                            trailing: const [Icon(Icons.search,color: Colors.grey,)],
                            // leading: Transform.translate(
                            //   offset: const Offset(-12, -13),
                            //   child: Transform.scale(
                            //     scale: 0.04,
                            //     child: CustomPaint(
                            //       size: const Size(25, 25),
                            //       painter: Logo(),
                            //     ),
                            //   ),
                            // ),
                            elevation:
                                MaterialStateProperty.resolveWith<double?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return 0.0; // Elevation when pressed
                                }
                                return 0.0; // Default elevation
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.white; // Elevation when pressed
                                }
                                return Colors.grey.shade200
                                    .withOpacity(0.4); // Default elevation
                              },
                            ),
                            hintText: 'Search...',
                            hintStyle:
                                MaterialStateProperty.resolveWith<TextStyle?>(
                              (Set<MaterialState> states) {
                                // Define the TextStyle based on different states
                                if (states.contains(MaterialState.pressed)) {
                                  return const TextStyle(
                                      color:
                                          kPrimaryBlueTest2, // Change the text color when pressed
                                      fontStyle: FontStyle
                                          .italic, // Change the font style when pressed
                                      fontSize:
                                          13, // Change the font size when pressed
                                      fontWeight: FontWeight.w400);
                                }
                                return const TextStyle(
                                    color: Colors.grey, // Default text color
                                    fontSize:
                                        13, // Change the font size when pressed
                                    fontWeight:
                                        FontWeight.w400 // Default font size
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
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: HomeAppBar(),
            ),
            SliverToBoxAdapter(child: CategoryTab()),
            /*   SliverToBoxAdapter(
              child:     const Divider(),
            ),*/
            const SliverToBoxAdapter(
              child: DealsTab(),
            ),
            SliverToBoxAdapter(
              child: Container(
                // color: Colors.grey.shade300,
                color: kPrimaryBlueTest,
                child: TabTitle(
                  title: 'Popular Products',
                  seeAll: () {
                    Get.toNamed(PoductsListScreen.routeName);
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: PopularDealTab(
              categoryId: "",
            )),
            SliverToBoxAdapter(
              child: Container(
                //height: 200,
                width: Get.width,
                //  color: Colors.grey.shade300,
                color: kPrimaryBlueTest,
                child: ExploreNewCategory(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // color: Colors.grey.shade300,
                color: kPrimaryBlueTest,
                child: TabTitle(
                  title: 'Explore More Products',
                  seeAll: () {
                    Get.toNamed(PoductsListScreen.routeName,
                        arguments: PoductsListArguments(
                          title: "Explore Products",
                          categoryId: "",
                        ));
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: ExploreMoreProducts(
              categoryId: "",
            )),

            /*        const SliverToBoxAdapter(
                child: ExploreMoreProducts(
              categoryId: "",
            )),*/
            SliverToBoxAdapter(
              child: Container(
                height: 20,
                width: Get.width,
                // color: Colors.grey.shade300,
                color: kPrimaryBlueTest,
              ),
            ),
            (addToCardController.productCount.value > 0)
                ? const SliverToBoxAdapter(
                    child: SizedBox(
                    height: 70,
                  ))
                : const SliverToBoxAdapter(
                    child: SizedBox(
                    height: 0,
                  ))
          ],
        ),
      ),
    );
  }
}

class DealsTab extends StatefulWidget {
  const DealsTab({super.key});

  @override
  State<DealsTab> createState() => _DealsTabState();
}

class _DealsTabState extends State<DealsTab> {
  final DealsController controller = Get.put(DealsController());

  final ScrollController _scrollController = ScrollController();

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.animateTo(
            _scrollController.position.pixels +
                getProportionateScreenWidth(280),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: controller.deals.isEmpty?Colors.white:Colors.grey.shade300,
      color: controller.deals.isEmpty ? Colors.white : kPrimaryBlueTest,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: kPrimaryBlueTest,
            child: TabTitle(
                title: titleCase("special deals for you"),
                seeAll: () {
                  Get.toNamed(SpecialDealScreen.routeName);
                }),
          ),
          GetBuilder<DealsController>(builder: (context) {
            if (controller.deals.isEmpty) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: SizedBox(
                  height: 140,
                  child: ListView.builder(
                    controller: _scrollController,
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Use a placeholder count
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: MyOrderShimmer(from: "myorder"),
                      );
                    },
                  ),
                ),
              );
            } else if (controller.hasError.value) {
              return Text('Error: ${controller.errorMsg.value}');
            } else {
              return Container(
                color: kPrimaryBlueTest,
                height: 200,
                child: ListView.builder(
                  controller: _scrollController,
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
                            categoryId:
                                controller.deals[index]['category'].toString(),
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
            }

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
          const SizedBox(height: 8),
          //  const Divider()
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        //  height: 80,
        //color: Colors.grey.shade200,
        color: kPrimaryBlueTest2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(
                  0,
                ),
              ),
              child: InkWell(
                onTap: () {
                  // Get.toNamed(MapScreen.routeName);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Text(userController.user.toString()),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                              )),
                          Text(
                            userController.user['party']?['address']
                                    ?['address_line1'] ??
                                'Loading...',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
