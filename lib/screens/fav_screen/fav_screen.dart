import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final CommonController cmncontroller = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    List<Widget> emptyCartWidgets = [
      const SizedBox(
        height: 18,
      ),
      Row(
        children: [
          Text(
            'My Favourites',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(
                20,
              ),
            ),
          ),
          const Spacer(),
          // const Icon(
          //   Icons.search,
          //   color: kPrimaryBlue,
          // ),
        ],
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      Lottie.asset('assets/lotties/cart.json',
          repeat: false,
          height: getProportionateScreenHeight(250.0),
          width: getProportionateScreenWidth(250.0)),
      SizedBox(
        height: getProportionateScreenHeight(10.0),
      ),

      Text(
        'Oops your wishlish is empty',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      Text(
        'It seems notinh in here. Explore more and shortlist some items',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: kTextColorAccent,
            ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      ElevatedButton(
        onPressed: () {
          cmncontroller.commonCurTab.value = 0;
          cmncontroller.update();
        },
        child: const Text(
          'Start Shopping',
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(16.0),
      ),
      // const TabTitle(
      //   title: 'Recommendation for you',
      //   padding: 0,
      // ),
      // SizedBox(
      //   height: getProportionateScreenHeight(240),
      //   child: Row(
      //     children: [
      //        Expanded(
      //         child: ProductCard(
      //           noPadding: true,
      //           onCardAddClicked: () {
      //                 setState(() {
      //                   //_selectedIndex = index;

      //                   /*  if(_selectedIndex == index){
      //                   _selectedIndex= -1;
      //                 }else{
      //                   _selectedIndex= index;
      //                 }*/
      //                 });
      //               },
      //               onCardMinusClicked: () {
      //                 setState(() {
      //                   //_selectedIndex = index;
      //                   /*  if(_selectedIndex == index){
      //                   _selectedIndex= -1;
      //                 }else{
      //                   _selectedIndex= index;
      //                 }*/
      //                 });
      //               },
      //         ),
      //       ),
      //       SizedBox(
      //         width: getProportionateScreenWidth(8),
      //       ),
      //       //  Expanded(
      //       //   child: ProductCard(
      //       //     noPadding: true,
      //       //     onCardAddClicked: () {
      //       //           setState(() {
      //       //             //_selectedIndex = index;

      //       //             /*  if(_selectedIndex == index){
      //       //             _selectedIndex= -1;
      //       //           }else{
      //       //             _selectedIndex= index;
      //       //           }*/
      //       //           });
      //       //         },
      //       //         onCardMinusClicked: () {
      //       //           setState(() {
      //       //             //_selectedIndex = index;
      //       //             /*  if(_selectedIndex == index){
      //       //             _selectedIndex= -1;
      //       //           }else{
      //       //             _selectedIndex= index;
      //       //           }*/
      //       //           });
      //       //         },
      //       //   ),
      //       // ),
      //     ],
      //   ),
      //),
    ];

    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            //  children: [Container()],
            children: emptyCartWidgets,
          ),
        ));
  }
}
