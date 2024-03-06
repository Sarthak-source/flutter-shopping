import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/add_to_cart_controller.dart';
import 'package:sutra_ecommerce/controllers/mycart_controller.dart';
import 'package:sutra_ecommerce/screens/product_detail.dart/product_detail.dart';
import 'package:sutra_ecommerce/utils/common_functions.dart';
import 'package:sutra_ecommerce/utils/screen_utils.dart';

import '../../controllers/product_detail_controller.dart';
import '../add_button.dart';
import '../loading_widgets/loader.dart';

class PopularCard extends StatefulWidget {
  final dynamic product;
  final String? isFrom;
  final bool? loader;
  final Function() onCardAddClicked;
  final Function() onCardMinusClicked;
   PopularCard({
    super.key,
    this.product,
    this.isFrom,
    this.loader,
     required this.onCardAddClicked,
     required this.onCardMinusClicked
  });

  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  RxInt quantity = 0.obs; // Initialize quantity as observable RxInt with value 0

  @override
  void initState() {
    super.initState();

    // if (widget.product != null && widget.product!["cart_count"] != null) {
    //   final cartCount = widget.product!["cart_count"];
    //   if (cartCount != null) {
    //     log("count::: ${cartCount.toString()}");
    //     final double? parsedCount = double.tryParse(cartCount.toString());
    //     if (parsedCount != null) {
    //       log('double count $parsedCount');
    //       log('int count ${parsedCount.toInt()}');
    //       quantity.value = parsedCount.toInt();
    //     }
    //   }
    // }
  }
final TextEditingController quantityCtrlr =TextEditingController();
  final AddToCartController addToCartController = Get.put(AddToCartController());
  final MyCartController myCartController = Get.put(MyCartController());
  final ProductDetailController prodDetailController = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    var productdeal = widget.product;
    if (widget.product != null && widget.product!["cart_count"] != null) {
      final cartCount = widget.product!["cart_count"];
      if (cartCount != null) {
        log("count::: ${cartCount.toString()}");
        final double? parsedCount = double.tryParse(cartCount.toString());
        if (parsedCount != null) {
          log('double count $parsedCount');
          log('int count ${parsedCount.toInt()}');
          quantity.value = parsedCount.toInt();
          quantityCtrlr.text =quantity.value.toString();
          print('quantityCtrlr.text:: ${quantityCtrlr.text}');
        }
      }
    }
    return Obx( () =>

       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey, // Border color
              width: 1.0, // Border width
            ),
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(8)),
            // boxShadow: [
            //   BoxShadow(
            //     color: kShadowColor,
            //     offset: Offset(
            //       getProportionateScreenWidth(3),
            //       getProportionateScreenWidth(3),
            //     ),
            //     blurRadius: 1,
            //   )
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    //log(widget.product.toString());
                    if(widget.isFrom=="more"){
                      print('isFrom==more');
                      prodDetailController.fetchProductDetail(widget.product['id'].toString());
                      prodDetailController.update();
                      /* Get.offNamed(ProductDetailScreen.routeName,
                arguments: ProductDetailArguments(productDetailData: widget.product));*/
                    }else{
                      Get.toNamed(ProductDetailScreen.routeName,
                          arguments: ProductDetailArguments(productDetailData: widget.product));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.product?['product_img'] ??
                          'http://170.187.232.148/static/images/dilicia.png',
                      fit: BoxFit.fill,
                      height: getProportionateScreenHeight(60),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 150,
                  child: Text(
                    titleCase(
                        widget.product?['name'].toLowerCase() ?? "Not given"),
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      //  "####${widget.product?['packing_qty'].toString()}",
                      "${convertDoubleToString(widget.product?['packing_qty'].toString() ?? '0.0')} ${widget.product?['packing_uom']}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: kTextColorAccent,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "₹ ${convertDoubleToString(widget.product?['price'].toString() ?? '0.0 ')}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                   // addToCartController.isLoading.value?Loader():
                    AddButton(
                      isLoading: widget.loader ?? false,
                      qty: quantity.value,
                      onChangedPressed: (value){
                        quantity.value = int.parse(value);
                        quantityCtrlr.text =quantity.value.toString();
                        controller.rxQty.value = quantity.value.toString();

                        addToCartController.addToCart(
                            quantity.value, widget.product?['id'], '1');

                      },
                      onAddPressed: (){

                        quantity.value++;
                        addToCartController.productCount++;
                        addToCartController.addToCart(
                            quantity.value, widget.product?['id'], '1');
                        addToCartController.update();
                        quantityCtrlr.text =quantity.value.toString();
                        controller.rxQty.value = quantity.value.toString();

                      },
                      onPlusPressed: (){
                        widget.onCardAddClicked();
                      //  final ValueNotifier<bool> isLoadingButton1 = ValueNotifier(false);
                        print('isloading in addtocart ${addToCartController.isLoading.value}');
                        controller.rxQty.value = quantity.value.toString();
                        quantity.value++;
                        quantityCtrlr.text =quantity.value.toString();
                        addToCartController.addToCart(
                            quantity.value,
                            widget.product?['id'],
                            '1');

                        addToCartController.productCount++;
                        addToCartController.update();
                      },
                      onMinusPressed: (){
                        widget.onCardMinusClicked();
                        //   if (quantity.value > 0) {
                        quantity.value--;
                        addToCartController.productCount--;
                        quantityCtrlr.text =quantity.value.toString();
                        controller.rxQty.value = quantity.value.toString();
                        addToCartController.addToCart(
                            quantity.value,
                            widget.product?['id'],
                            '1');
                        addToCartController.update();
                        //  }


                        /* quantity.value--;
                    addToCartController.productCount--;
                    addToCartController.addToCart(
                        quantity.value,
                        widget.product?['id'],
                        '1');
                    addToCartController.update();*/
                      },
                      qtyController: quantityCtrlr,
                    ),
                   /* Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kPrimaryBlue, // Set your desired border color
                          width: 1.0, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(10.0), // Set the border radius
                      ),
                      child: SizedBox(
                        height: 35,
                        width: quantity.value == 0
                            ? 76
                            : (quantity.toString().length * 11) + 75,
                        child: quantity.value == 0
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: kPrimaryBlue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Set your desired border radius
                                  ),
                                ),
                                onPressed: () async {
                                  log('20');
                                  quantity.value++;
                                  addToCartController.productCount++;
                                  addToCartController.addToCart(
                                      quantity.value, widget.product?['id'], '1');

                                  addToCartController.update();
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                      color: kPrimaryBlue,
                                      fontSize: getProportionateScreenWidth(14)),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Transform.translate(
                                    offset: const Offset(-12, 0),
                                    child: SizedBox(
                                      width: 12,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(
                                          Icons.remove,
                                          color: kPrimaryBlue,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          quantity.value--;
                                          addToCartController.productCount--;
                                          addToCartController.addToCart(
                                              quantity.value,
                                              widget.product?['id'],
                                              '1');
                                          addToCartController.update();

                                   },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width:
                                        (quantity.value.toString().length * 11) +
                                            20,
                                    color: kPrimaryBlue,
                                    child: Center(
                                      child: Text(
                                        quantity.value.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(3.5, 0),
                                    child: SizedBox(
                                      width: 12,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: Colors.green,
                                        icon: const Icon(
                                          Icons.add,
                                          color: kPrimaryBlue,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          quantity.value++;
                                          addToCartController.addToCart(quantity.value, widget.product?['id'], '1');

                                          addToCartController.productCount++;
                                          addToCartController.update();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),*/
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
