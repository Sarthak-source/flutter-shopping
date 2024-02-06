import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sutra_ecommerce/screens/map_screen.dart';
import 'package:sutra_ecommerce/utils/network_repository.dart';

import '../../constants/colors.dart';
import '../../models/category.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/category_card.dart';
import '../../widgets/deal_card.dart';
import '../../widgets/indi_deal_card.dart';
import '../../widgets/tab_title.dart';
import '../category_screen.dart';
import '../product_screen/produts_screen.dart';
import '../search_screen.dart';
import '../special_deal_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      const Category(
        'Vegetables',
        'assets/images/vegetable_home.png',
        kAccentGreen,
      ),
      const Category(
        'Fruits',
        'assets/images/fruit_home.png',
        kAccentRed,
      ),
      const Category(
        'Milks & Egg',
        'assets/images/egg_home.png',
        kAccentYellow,
      ),
      const Category(
        'Meat',
        'assets/images/meat_home.png',
        kAccentPurple,
      ),
    ];
    ScreenUtils().init(context);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: HomeAppBar(),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: SearchBar(
  elevation: MaterialStateProperty.resolveWith<double?>(
    (Set<MaterialState> states) {
      // Define the elevation based on different states
      if (states.contains(MaterialState.pressed)) {
        return 10.0; // Elevation when pressed
      }
      return 5.0; // Default elevation
    },
  ),
  hintText: 'Search...',
  hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
    (Set<MaterialState> states) {
      // Define the TextStyle based on different states
      if (states.contains(MaterialState.pressed)) {
        return const TextStyle(
          color: Colors.blue, // Change the text color when pressed
          fontStyle: FontStyle.italic, // Change the font style when pressed
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

        const SliverToBoxAdapter(
          child: DealsTab(),
        ),
        const SliverToBoxAdapter(child: CategoryTab()),
        SliverToBoxAdapter(
          child: TabTitle(
              title: 'Popular Deals',
              seeAll: () {
                Get.toNamed(PoductsListScreen.routeName);
              }),
        ),
        const PopularDealTab(),
        // SliverToBoxAdapter(
        //   child: CustomPaint(
        //     size: Size(36, 36),
        //     painter: RPSCustomPainter(),
        //   ),
        // ),
      ],
    );
  }
}

class PopularDealTab extends StatelessWidget {
  const PopularDealTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: getProportionateScreenWidth(8),
      ),
      delegate: SliverChildListDelegate(
        [
          const IndiDealCard(
            isLeft: true,
          ),
          const IndiDealCard(
            isLeft: false,
          ),
        ],
      ),
    );
  }
}

class DealsTab extends StatelessWidget {
  const DealsTab({super.key});

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
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DealCard(),
              DealCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryTab extends StatefulWidget {
  const CategoryTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  late Future<dynamic> _categoryFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = NetworkRepository.getCategories(
        level: '1', parent: ''); // Call your data fetching method here
  }

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
          FutureBuilder(
            future: _categoryFuture,
            builder: (context, snapshot) {
              log(snapshot.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Use a placeholder count
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child:
                              CategoryCardPlaceholder(), // Create a placeholder widget
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String, dynamic> responseData = snapshot.data;
                List categories = responseData['body']['results'];

                log(categories.toString());

                return SizedBox(
                  height:
                      100, // Set a fixed height or adjust according to your needs
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection:
                        Axis.horizontal, // Set the scroll direction
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(PoductsListScreen.routeName,
                                arguments: PoductsListArguments(
                                    title: categories[index]['name'],
                                    categoryId: categories[index]['id']));
                          },
                          child: CategoryCard(
                            Category(
                                categories[index]['name'],
                                categories[index]['categories_img'],
                                Colors.amber),
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

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            const IconButton(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.location_fill,
                  color: kPrimaryBlue,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planet Namex 989',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'Norristown, Pennsyvlvania, 19403',
                    style: TextStyle(
                      color: kTextColorAccent,
                      fontSize: getProportionateScreenWidth(
                        12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
