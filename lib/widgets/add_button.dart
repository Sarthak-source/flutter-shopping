import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sutra_ecommerce/constants/colors.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import 'loading_widgets/loader.dart';

class AddButton extends StatefulWidget {
  final Function() onPlusPressed;
  final Function() onMinusPressed;
  final Function() onAddPressed;
  final Function(String) onChangedPressed;
  final int qty;
  final TextEditingController? qtyController;
  final bool isLoading;
  const AddButton({
    Key? key,
    required this.onPlusPressed,
    required this.onMinusPressed,
    required this.onAddPressed,
    required this.onChangedPressed,
    required this.qty,
    required this.qtyController,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

final CommonController controller = Get.put(CommonController());

class _AddButtonState extends State<AddButton> {
  int quantity = 0;
  late FocusNode focusNode;
  //TextEditingController qtyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.qtyController?.text=widget.qty.toString();
    focusNode = FocusNode();
    print('quantityCtrlr.text in addscren ${widget.qtyController?.text}');
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    quantity = widget.qty;
    return quantity == 0
        ? SizedBox(
      width: 80,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
              color: kPrimaryBlue), // Specify the border color here
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8.0), // Adjust the border radius as needed
          ),
        ),
        onPressed: widget.onAddPressed,

        /*() {
                    setState(() {
                      quantity = 1;
                      qtyCtrl.text =quantity.toString();
                      controller.rxQty.value = quantity.toString();
                      print('controller.rxQty.value::: ${controller.rxQty.value}');
                    });
                  },*/
        child: const Text('Add'),
      ),
    )
        :
        //  Obx(() =>
        widget.isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Loader(),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(5), // Set the border radius here
                  border: Border.all(
                    color: kPrimaryBlue, // Specify the border color here
                  ),
                ),
                width: quantity.toString().length == 1
                    ? 80
                    : 60 + 18.0 * quantity.toString().length,
                // : 60 + 18.0 * controller.rxQty.value.length,
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onMinusPressed,

                      /*  () {
                          setState(() {
                            if (quantity > 0) {
                              quantity--;
                              qtyCtrl.text =quantity.toString();
                              controller.rxQty.value = quantity.toString();
                            }
                          });
                        },*/
                      child: Container(
                        width: 25,
                        height: 30,
                        decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          color: kPrimaryBlue,
                        ),
                        child: const Icon(Icons.remove,
                            size: 20, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 12.0 * quantity.toString().length,
                      //  width: 12.0 * controller.rxQty.value.length,
//width: 80,
                      height: 30,
                      decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          //border: Border.all(color: kPrimaryBlue), // Circular border color
                          ),
                      child: TextField(
                        //readOnly: true, // Make the TextField read-only
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], // Allow only numeric input
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        decoration: const InputDecoration(
                          isDense: true,

                          border: InputBorder.none, // Remove default border
                          contentPadding:
                              EdgeInsets.only(top: 5), // Remove default padding
                        ),
                        onChanged: (value) {
                          widget.onChangedPressed(value);
                          // if(int.parse(value))
                          //  quantity = int.parse(value);
                          //  qtyCtrl.text =quantity.toString();
                          //  controller.rxQty.value = quantity.toString();
                        },

                        onEditingComplete: () {
                          setState(() {});
                        },
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: kPrimaryBlue, fontSize: 16),
                        controller: widget
                            .qtyController, //TextEditingController(text: quantity.toString()),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: widget.onPlusPressed,
                      /* () {
                          setState(() {
                            quantity++;
                            qtyCtrl.text =quantity.toString();
                            controller.rxQty.value = quantity.toString();
                          });
                        },*/
                      child: Container(
                        width: 25,
                        height: 30,
                        decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          color: kPrimaryBlue,
                        ),
                        child: const Icon(Icons.add,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
    //  );
  }
}
