import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sutra_ecommerce/controllers/common_controller.dart';

import '../config/common.dart';

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
  final bool constWidth;
  final String? parentCode;

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
    this.constWidth = false,
    this.parentCode,
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
  RxInt listLength = 300.obs;
  String ordersMilk = "";
  Map? storedUserData;

  @override
  void initState() {
    super.initState();
    storedUserData = box?.get('userData');
    print(
        'userdata in popularcard ${storedUserData?['party']['orders_milk'].toString()}');
    ordersMilk = storedUserData?['party']['orders_milk'] != null
        ? storedUserData!['party']['orders_milk'].toString()
        : "";

    log(listLength.toString());
    itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _onScroll() {
    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      final maxVisibleIndex = positions
          .map((item) => item.index)
          .reduce((max, item) => item > max ? item : max);

      if (maxVisibleIndex >= listLength.value - 1) {
        _fetchMoreInList();
      }
    }
  }

  _fetchMoreInList() {
    listLength.value = listLength.value + 10;
  }

  @override
  void didUpdateWidget(covariant AddButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    itemPositionsListener.itemPositions.removeListener(_onScroll);
    super.dispose();
  }

  List<int> generateList(int minOrder, int length) {
    print(
        'widget.parentCode in add btn ${widget.parentCode} ordersmilk:: $ordersMilk');
    if (widget.parentCode == "1011" && ordersMilk == "Crate") {
      return List.generate(length, (index) => (index + 1));
    } else {
      return List.generate(length, (index) => (index + 1) * minOrder);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("{widget.minOrder.toString()} ${widget.minOrder.toString()}");

    quantity = widget.qty;
    widget.qtyController?.text = "";
    widget.qtyController?.text = widget.qty.toString();
    focusNode = FocusNode();
    itemScrollController = ItemScrollController();

    int indexOfQuantity =
        generateList(widget.minOrder, listLength.value).indexOf(widget.qty);

    log(indexOfQuantity.toString());

    int customCeil(int number, int increment) {
      int quotient = number ~/ increment;
      int result = (quotient + 1) * increment;
      return result;
    }

    if (indexOfQuantity == -1) {
      indexOfQuantity = 0;
      log('------------------------------');
      log("quantity.toString() ${quantity.toString()}");
      log("test ${generateList(widget.minOrder, listLength.value).indexOf(quantity).toString()}");
    }

    return widget.qty == 0
        ? SizedBox(
            width: widget.width,
            height: 32,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black.withOpacity(0.2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: widget.isLoading ? null : widget.onAddPressed,
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: widget.isLoading
                      ? Colors.grey
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.5),
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            width: widget.constWidth
                ? 140
                : quantity.toString().length == 1
                    ? (widget.textWidth! + 20)
                    : widget.textWidth! + 18.0 * quantity.toString().length,
            child: Row(
              children: [
                InkWell(
                  onTap: widget.isLoading ? null : widget.onMinusPressed,
                  child: Container(
                    width: 35,
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget.isLoading
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: widget.isLoading
                          ? Colors.grey
                          : Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 50,
                  height: 30,
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                    onTap: () {
                      if (widget.isLoading) return;
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Obx(() {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 30,
                              ),
                              titlePadding: const EdgeInsets.all(12),
                              title: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text("Quantity"),
                                      Spacer(),
                                      Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ScrollablePositionedList.separated(
                                  scrollOffsetController:
                                      scrollOffsetController,
                                  initialScrollIndex: indexOfQuantity,
                                  itemScrollController: itemScrollController,
                                  itemPositionsListener: itemPositionsListener,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Colors.grey.withOpacity(0.6),
                                      thickness: 0.5,
                                    );
                                  },
                                  itemCount: listLength.value,
                                  itemBuilder: (_, i) {
                                    return Container(
                                      color: indexOfQuantity == i
                                          ? Colors.grey.withOpacity(0.2)
                                          : Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            quantity = generateList(
                                                widget.minOrder,
                                                listLength.value)[i];
                                          });
                                          widget.onChangedPressed(
                                              "${generateList(widget.minOrder, listLength.value)[i]}");

                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5,
                                              top: 5,
                                              right: 5,
                                              left: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${generateList(widget.minOrder, listLength.value)[i]}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: indexOfQuantity == i
                                                        ? Colors.black
                                                            .withOpacity(0.8)
                                                        : Colors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                widget.parentCode == "1011"
                                                    ? ordersMilk ?? ""
                                                    : widget.units,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: indexOfQuantity == i
                                                        ? Colors.black
                                                            .withOpacity(0.8)
                                                        : Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          });
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
                  onTap: widget.isLoading ? null : widget.onPlusPressed,
                  child: Container(
                    width: 35,
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget.isLoading
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: widget.isLoading
                          ? Colors.grey
                          : Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
