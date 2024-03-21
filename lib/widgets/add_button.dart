import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
  final double? width;
  final double? textWidth;
  final int minOrder;
  final String units;

  const AddButton({
    super.key,
    required this.onPlusPressed,
    required this.onMinusPressed,
    required this.onAddPressed,
    required this.onChangedPressed,
    required this.qty,
    required this.qtyController,
    required this.isLoading,
    this.minOrder = 1,
    this.width = 80.0,
    this.textWidth = 60,
    this.units = 'items',
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

final CommonController controller = Get.put(CommonController());

class _AddButtonState extends State<AddButton> {
  int quantity = 0;
  late FocusNode focusNode;
  ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int listLength = 150;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.qtyController?.text = widget.qty.toString();
    //itemScrollController=ItemScrollController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  List<int> generateList(int minOrder, int length) {
    return List.generate(length, (index) => (index + 1) * minOrder);
  }

  @override
  Widget build(BuildContext context) {
    quantity = widget.qty;
    widget.qtyController?.text = widget.qty.toString();
    focusNode = FocusNode();
    itemScrollController = ItemScrollController();

    int indexOfQuantity =
        generateList(widget.minOrder, listLength).indexOf(widget.qty);

    log(indexOfQuantity.toString());

    int customCeil(int number, int increment) {
      int quotient = number ~/ increment;
      int result = (quotient + 1) * increment;
      return result;
    }

    if (indexOfQuantity == -1) {
      // If the quantity is not found in the list, set a default index
      indexOfQuantity = 0;
      //quantity = customCeil(quantity, widget.minOrder);

      // indexOfQuantity =
      //     generateList(widget.minOrder, listLength).indexOf(quantity);

      log('------------------------------');
      log("quantity.toString() ${quantity.toString()}");
      log("test ${generateList(widget.minOrder, listLength).indexOf(quantity).toString()}");
    }

    return widget.qty == 0
        ? SizedBox(
            width: widget.width,
            height: 32,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: widget.onAddPressed,
              child: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        : widget.isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Loader(),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                width: quantity.toString().length == 1
                    ? (widget.textWidth! + 20)
                    : widget.textWidth! + 18.0 * quantity.toString().length,
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onMinusPressed,
                      child: Container(
                        width: 25,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Color.fromARGB(255, 213, 213, 213),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 10.0 * quantity.toString().length,
                      height: 30,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 30,
                                ),
                                //contentPadding: const EdgeInsets.all(12),
                                title: Row(
                                  children: [
                                    const Text("Quantity"),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close))
                                  ],
                                ),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ScrollablePositionedList.separated(
                                    scrollOffsetController:
                                        scrollOffsetController,
                                    initialScrollIndex: indexOfQuantity,
                                    itemScrollController: itemScrollController,
                                    itemPositionsListener:
                                        itemPositionsListener,
                                    separatorBuilder: (context, index) {
                                      return  Divider(color: Colors.grey.withOpacity(0.6), thickness: 0.5,);
                                    },
                                    itemCount: listLength,
                                    itemBuilder: (_, i) {
                                      return Container(
                                        color: indexOfQuantity == i
                                            ? const Color.fromARGB(
                                                255, 6, 183, 243)
                                            : Colors.white,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              quantity = generateList(
                                                  widget.minOrder,
                                                  listLength)[i];
                                            });
                                            widget.onChangedPressed(
                                                "${generateList(widget.minOrder, listLength)[i]}");

                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5, top: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${generateList(widget.minOrder, listLength)[i]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                      color: indexOfQuantity == i
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                                const Spacer(),
                                                Text(widget.units,style: TextStyle(
                                                  fontSize: 13,
                                                      color: indexOfQuantity == i
                                                          ? Colors.white
                                                          : Colors.grey),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onChanged: (value) {
                          widget.onChangedPressed(value);
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        controller: widget.qtyController,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: widget.onPlusPressed,
                      child: Container(
                        width: 25,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Color.fromARGB(255, 213, 213, 213),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
