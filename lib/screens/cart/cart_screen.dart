import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/controllers/my_cart_controller.dart';

import '../../constants/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/order_card.dart';
import '../add_address/add_address_screen.dart';

class CartScreen extends StatelessWidget {
   const CartScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MyCartController>(
        builder: (controller) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'My Cart',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(
                          20,
                        ),
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.search,
                    color: kPrimaryBlue,
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(16.0),
              ),
             Expanded(
               child: SingleChildScrollView(
                 child: ListView.builder(
                   shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: controller.mycartItems.length,
                     itemBuilder: (context,index) {

                     return  OrderCard(mycartItem:controller.mycartItems[index]);
                 }),
               ),
             )   ,

            /*  Column(
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      index == 0
                          ? const OrderCard()
                          : const OrderCard(),
                      SizedBox(
                        height: getProportionateScreenHeight(8.0),
                      ),
                    ],
                  ),
                ),
              ),*/

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        controller.mycartTotalValue.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.grey,fontSize: 14),
                        ),
                        Text(
                            controller.mycartTotalGst.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.grey,fontSize: 14),
                        ),  Text(
                            controller.mycartTotalAmount.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const StadiumBorder(),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size.fromHeight(
                            getProportionateScreenHeight(48),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddAddressScreen.routeName);
                      },
                      child: const Text('Buy Now'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(24.0),
              ),
            ],
          ),
        ),
      );}
    );
  }
}
